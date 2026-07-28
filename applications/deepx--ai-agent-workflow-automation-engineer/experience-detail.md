---
title: "Experience Detail — Agent Workflow Infrastructure"
subtitle: "Supplement to the résumé · [SW] AI Agent-Based Workflow Automation Engineer, DEEPX"
author: "Junghan Kim (김정한)"
date: "July 2026"
---

> [email removed] · github.com/junghan0611 · notes.junghanacs.com ·
> linkedin.com/in/junghan-kim-1489a4306

# 0. How to read this document

The posting asks for evidence — *demo, repo, write-up, architecture*. This document is the
write-up. Each section states the problem, what I owned, the decision that mattered, the measured
outcome, and where you can check it yourself. Public repositories are linked; work done inside my
employer is marked **[internal]** and is described by design and outcome, never by pasting code or
customer data.

Five sections map to the five Responsibilities in the posting, in order. Section 6 states what I
have **not** done, so the technical interview can start from an accurate line.

| Posting responsibility | Section |
|---|---|
| On-prem code agent workflow infrastructure (orchestration, tool registry, permissions, audit logs) | §1, §2 |
| Enterprise system integration via APIs/webhooks | §3 |
| Reliability patterns (retries, timeouts, idempotency, fallbacks, human-in-the-loop) | §2, §4 |
| Evaluation & observability (regression, metrics, monitoring, incident playbooks) | §1, §5 |
| Cost/latency/quality tuning of developer and automation pipelines | §1, §3, §5 |

# 1. Running an agent runtime in production — instrumentation, rollback, promotion policy

**Context.** I have operated a self-hosted multi-agent runtime continuously since February 2026 on
Oracle Cloud ARM (aarch64) under Docker, serving Telegram, Discord and Mattermost channels for
real daily users. Over roughly five months it went through 20+ upstream version cycles. Upstream
is maintained by one person, and no one on my side owns upstream — so **the operating layer is
mine, and upstream changes have to be re-interpreted here or they kill the deployment.**

**What I owned.** Version tracking, promotion decisions, incident response, configuration, the
memory layer, and the written policy that came out of it.

**The incident that produced the policy.** After a two-version jump the runtime's response latency
collapsed. I instrumented rather than guessed: the gateway process was spinning at 102% CPU on a
single node thread with no child spawn, boot time had gone from 11s to 88s, and sessions were
stalling with `state=processing age=164s`. I reproduced it on a clean boot, which ruled out my own
configuration as the cause. The root cause I isolated was a cold-persisted plugin registry
interacting with a repair command: the registry rebuild silently reduced active plugins, and the
first inbound message then triggered a dependency install **in the middle of the hot path**.

The rollback target mattered more than the rollback. I did not go back to the last version I knew
was quiet; I went to the **latest known-good** one, because an earlier version would have forced a
separate API key for image generation that the newer one routed through an existing flat-rate
credential. Verified after rollback: ready in 11.3s, plugins restored, 0.07% CPU at idle, zero
stalled-session diagnostics. Operator attention spent: about five hours.

**The part that outlives the incident** is the written promotion policy: no two-version jumps;
wait-and-watch after release; stage on a non-production agent for at least 24 hours before
promoting; a single `stuck session` line is itself a reason to pause; **responsiveness is the SLO
and perceived latency is a P0.** This is the "incident response playbook" the posting asks for,
and it exists because I paid for it once.

**The follow-up shows the same method in the other direction.** Reading an upstream release note,
I identified two lines that were the principled fix for the failure I had diagnosed — scoping
runtime preloads to the plugin ids actually derived from config, and caching plugin tool
descriptors so repeated planning skips runtime loading. I retried the intermediate version first,
reproduced my own incident in ten minutes, and then jumped straight to the version carrying the
fix.

| Measure | Before | After |
|---|---|---|
| Boot | 45.4 s | **7.3 s → 5.8 s after hardening** |
| Resident memory | 816 MiB | **246 MiB** |
| Dependency staging on the hot path | occurring | **0** |
| Dangling / stale sessions | 72 | **16** |

**One judgment worth stating.** The runtime's own diagnostic command emitted security advisories —
credential permissions, an image-model swap, multi-user exposure. I validated each against our
actual deployment context, concluded they were false positives here, and did **not** apply them. I
also did not run its auto-repair mode, because it rewrites configuration. Configuration drift
across that period: zero. The most common failure in agent adoption is doing what the tool says
without checking whether the tool's assumptions hold.

**Check it.** Version-by-version impact notes, incident timelines and the promotion policy live in
my working log; I can walk any of them on a shared screen. `github.com/junghan0611/agent-config`
is the public surface of the configuration layer.

# 2. `entwurf` — a dispatch substrate with permission boundaries, not a super-agent

**Problem.** Once you run more than one agent harness, the naive fix is a supervising agent that
drives the others. That concentrates authentication, transcripts and runtime into one process and
makes every boundary implicit.

**What I built.** A dispatch substrate that lets different harnesses address one another by a
stable id **while each keeps its own transcript, authentication and runtime.** The human stays the
orchestrator; the substrate only routes. Addressable participants connect through different
mechanisms on purpose — a control socket, a mailbox the harness pulls from itself, native
injection, and an outbound MCP sender that can deliver to existing participants but does not yet
own an address and a reply rail.

**The decision that mattered: refusing to unify.** Making every harness look the same would have
meant terminating each one's auth and session ownership inside my process. I kept them different
and wrote the boundary down, including **the participants that are not fully supported** — an
outbound-only sender is documented as outbound-only rather than described as a citizen.

**Third-party validation.** A developer I have never met used that documented extension boundary to
contribute an ACP backend for an enterprise agent runtime I had never written for — 11 files,
+885 lines ([entwurf#40](https://github.com/junghan0611/entwurf/pull/40)). He found the extension
point exactly where the architecture said it was. That is stronger evidence for the boundary than
anything I can assert about my own design. The package has **1,395 npm installs in the preceding
30 days** (measured 2026-07).

**Why this maps to the posting.** "Orchestration, tool registry, permissions" is precisely this
layer: who may be addressed, through which transport, under whose credentials, and what happens to
a message addressed to a participant that cannot reply.

**Check it.** `npm install -g @junghanacs/entwurf`, then `entwurf check-bridge`. The boundary
contract, deterministic checks and a clean-host path are in the repository:
[github.com/junghan0611/entwurf](https://github.com/junghan0611/entwurf).

# 3. Enterprise integration and domain-owner agents — putting agents on systems that already run **[internal]**

**Context.** At my current employer there was no shared GPU, no embedding capability, and no
pipeline collecting work data when I joined. The work became two stages: build the ground, then
put agents on the people who own the domains.

**Stage 1 — infrastructure (2025.06–09).** Three RTX 5080 nodes joined by a 10G network under
declarative NixOS, running 17 Docker services; roughly 40 workflow nodes in n8n wired to 2,945
document embeddings in pgvector; Airbyte connectors consolidating the support, document and issue
systems into one PostgreSQL store; the internal portal placed behind Cloudflare Zero Trust.

**The decision that mattered: serving embeddings and reranking in-house.** Both models run on our
own GPUs and containers rather than an external API. Internal documents must not leave the
building, and retrieval quality has to be ours to fix. This is also the cost and latency lever the
posting names — the tuning surface belongs to us instead of to a vendor's pricing page.

**Stage 2 — agents on people (2026.05–present).** Once the ground existed, the requests changed.
What other teams asked for was not *"build me a dashboard"* but ***"make this run without me."***
So I did not build dashboards, and I did not replace the running cloud, support and operations
systems. I attached read-only work surfaces on top of them.

- A **VOC and support workbench** fixes the period, unit and inclusion policy of every query so an
  aggregate does not drift between questions, and traces any number back to the individual
  conversation it came from. The operations team reads it every morning.
- An **incident workbench** recovers outages, VOC records, device logs and runtime data onto a
  single KST time axis. Its first consumer is an agent, not a person — so when input or evidence
  fails the validation contract it **stops** instead of logging a warning and continuing, and it
  refuses to execute an outbound action that fails the gatekeeper check.

**Boundaries I set before capability.** Agents are not given credentials. Raw personal data does
not land in documents, sessions or commits. The default path is read-only. In a place with real
customer data, deciding what must not happen comes before deciding what can.

**Why this maps to the posting.** "Integrate agents with enterprise systems (Slack, Jira/Confluence,
CRM/ERP, internal DBs) via APIs/webhooks" is the same shape of work. My public skill surface
already carries Slack, Jira/Confluence ingestion, self-hosted Forgejo and project-tracker adapters
as agent-callable commands.

# 4. `forge-config` — a code agent loop with an audit trail and a human in the loop

**Problem.** If agents are going to touch a codebase, the judgment has to survive outside the
session. Handing the work surface to a hosted coding agent gives up exactly that.

**What I built.** A development loop on self-hosted Forgejo. A domain conversation produces a
request; a bot or a sweeper opens an issue with labels and source context; a dispatcher bot wakes
on the label or webhook, asks the owning agent for a read-only first review, records that review
back onto the issue, and closes the triage cycle. A human then reads a sorted backlog and calls for
implementation in focused batches.

**The decisions that mattered are the refusals**, and they are written into the repository as
non-goals: this is not an automatic coding factory, not an operations dashboard product, and not a
replacement for the human deciding what gets built. The dispatcher is a **dispatcher and recorder,
never an implementer**, and its "done" label means *first-pass triage complete*, not *implemented*.
That is the human-in-the-loop handoff the posting asks for, stated as an invariant rather than a
feature.

**Reliability and audit, concretely.** The comment marker records schema version, report id, session
key, issue timestamp, lifecycle labels, provider and model, and the configuration commit. The
purpose is single: **agent session memory and webhook replay must never win against current forge
state.** A durable store outranks an agent's recollection. Replay and idempotency smoke tests pass
with no duplicate reports produced; a snapshot drift guard blocks mutation when the world moved
under the plan; mutation is gated deterministically and reviewed before it is applied.

**Landed evidence.** The auto-fix lane reached green on two repositories through the full label
lifecycle, and a first implementation seed performed a bounded workspace-guard patch, exposed a
no-match search as a non-fatal sweep case, and passed a post-fix regression check.

**A borrowing I bounded deliberately.** I took the *safety grammar* of a large open-source sweeper —
conservative defaults, review-before-mutation, durable reports, marker-backed comments, snapshot
drift guards, deterministic mutation gates — and did **not** copy its product pipeline or its
platform-scale machinery. Being able to state which half you took is part of the engineering.

**Check it.** [github.com/junghan0611/forge-config](https://github.com/junghan0611/forge-config) —
the README states the loop and the non-goals; the roadmap states the safety grammar and what was
not copied.

# 5. `andenken` and the skill surface — evaluation, regression, and provenance

**Memory as an independent layer.** Running the agent runtime surfaced a memory problem, so I took
the markdown chunking and embedding logic out of the runtime and rebuilt it as its own layer on
LanceDB. I split memory into three axes and shipped only what I had: **embedding/semantic search is
live**; blocking pre-answer recall with a timeout boundary and graceful degradation is specified but
**not implemented in this repository**; nightly consolidation is **not implemented**. Declaring the
unbuilt axes is part of the design, not an omission.

Retrieval is hybrid — vector plus full-text with **score normalization**, cross-lingual expansion
through a personal vocabulary graph (about 3,900 triples and 2,400 Korean↔English mappings), and
**recall tracking** so that what actually gets retrieved can feed consolidation later. The finding
that forced the vocabulary layer is worth stating: **embeddings alone would not widen recall over a
Korean corpus reliably**, because Korean concept names, English tags and personal vocabulary drift
apart. The knowledge being written in Korean had to be a design input.

**Evaluation is a command, not an opinion.** `./run.sh golden` is the retrieval regression gate and
`./run.sh doctor --md` reports index gaps — the same shape as the "regression tests, task success
metrics, monitoring" the posting names, at the scale I actually operate.

**Provenance on the tool surface.** My skill configuration fans **one skill SSOT into six harness
surfaces** — the same capability reachable from Claude Code, Codex, pi, Antigravity and OpenClaw
without any of them being replaced or having its identity rewritten. Over 40 skills run against a
real corpus. Built CLI artifacts record source revision, source-tree digest and binary SHA-256, and
`./run.sh env` reports drift between what the document claims and what is installed. **If reality
drifts from the document, the check should say so before a user has to infer it from a failure.**

**Working with the loop, not just on it.** Running three coding agents in parallel with myself as
PM produced 24 commits, 163 passing tests and zero file conflicts in a day. The number I care about
is the third one: the conflict count is a property of how the work was partitioned and handed off,
not of the models.

**Check it.** [github.com/junghan0611/andenken](https://github.com/junghan0611/andenken) —
`./run.sh search:md`, `golden`, `doctor --md`.
[github.com/junghan0611/agent-config](https://github.com/junghan0611/agent-config) —
`./run.sh setup`, then `./run.sh env`.

# 6. Boundaries — what I have not done

Stated plainly so the technical interview starts from an accurate line.

- **LangGraph and OpenAI Agents SDK: not used.** n8n I have run in production (40+ workflow nodes).
  My orchestration was built directly on harness boundaries rather than on a framework.
- **Kubernetes: no operational experience.** On-prem for me has meant Docker, declarative NixOS,
  Cloudflare Zero Trust and an ARM cloud host operated continuously — containers, secrets and
  network boundaries, but not k8s.
- **Python is a tool language for me, not a primary one.** My primary languages are Go, Clojure,
  Zig and TypeScript; the posting's `Python and/or TypeScript` is satisfied on the TypeScript side
  (`entwurf` is a published npm package; a React 19 viewer is in production use).
- **Prompt-injection defense is not something I have threat-modelled explicitly.** I have built
  adjacent things — read-only defaults, withheld credentials, gatekeeper validation before outbound
  actions, treating tool output as untrusted input — but I will not call that a prompt-injection
  practice.
- **Large-scale CI/CD ownership: no.** I build deterministic verification gates and repo-scale
  sweeps; I have not owned an organisation's CI platform.
- **Model training and fine-tuning: not my axis.** I serve, retrieve, orchestrate and operate. I
  would rather say that than let it be discovered later.
- **Semiconductor domain: adjacent only.** I am in year two of a national R&D program porting an
  NPU workload across accelerator families, and I have deployed on RPi5 + Hailo-8 under Yocto. That
  is why DEEPX's problem space reads as familiar to me — but this role is internal engineering
  productivity, and I am not claiming NPU expertise for it.
