---
title: "Experience Detail — Embedded Linux, Board Boundaries, Cross-Architecture Porting"
subtitle: "Supplement to the résumé · Embedded / BSP axis"
author: "Junghan Kim (김정한)"
date: "August 2026"
---

> [email removed] · github.com/junghan0611 · notes.junghanacs.com ·
> ax.junghanacs.com · linkedin.com/in/junghan-kim-1489a4306

# 0. What I am claiming, and what I am not

I will start with the boundary, because a BSP team can check it in one question and I would rather
you have it on page one.

**I have not ported U-Boot, and I have not authored device trees for new hardware platforms.** I
have not written or maintained production kernel drivers, and I do not have Assembly in my working
practice. If those four are the job, a pure BSP engineer beats me on paper and should.

**What I do have** is the layer immediately above and around them, at product scale and shipped:
Linux-based embedded products taken from hardware bring-up to mass production; a port that moved a
product core from ARMv7/glibc on a vendor sysroot to RISC-V on statically linked musl; a board HAL
extracted so the core no longer knows what board it runs on; Yocto and Android deployments sharing
one codebase; and kernel-layer research on non-volatile-memory filesystems and NUMA lock behaviour.

The problem of *"make this run on this new board, and keep it stable"* is the one I have spent the
most time on, even if I reached it from the product side rather than the bootloader side.

| Typical BSP-driver requirement | Where I stand | Section |
|---|---|---|
| Bootloader (LK, U-Boot) porting | **Gap** — stated, not worked around | §0, §5 |
| Kernel device driver development | **Gap** — my kernel-layer work is research | §3, §5 |
| Linux kernel debugging | Partial — instrumentation, tracing, field reproduction | §1, §3 |
| Embedded board bring-up | **Strong** — to mass production, twice | §1, §2, §4 |
| Kernel / root filesystem customization | Partial — Yocto images, static musl userland | §2 |
| Verification and test-tool development | Strong — aging automation, real-device fan-out | §1 |
| Working with the hardware team through bring-up | **Strong** — the full product lifecycle | §1, §4 |
| ARM architecture familiarity | Working — ARMv7 product, cross-ISA port | §2 |
| Related degree (CS/EE), BSc or above | Met — MSc, and doctoral coursework completed | §3 |

# 1. Zigbee/Wi-Fi gateway — firmware to mass production

**Context.** A smart-home gateway product with a legacy C Zigbee SDK, shipping on constrained
hardware, with a hardware team on the other side of every bug.

**What I owned.** The firmware, and then more than the firmware.

**Decisions that mattered.**

- **Isolating the vendor SDK behind a type-safe FFI layer.** The legacy C Zigbee SDK integration
  was rewritten behind Zig's FFI boundary rather than being spread through the codebase. Vendor
  code stayed vendor code; our invariants stayed checkable.
- **One explicit state machine across driver, protocol and cloud layers.** A single `HubState` with
  a pure `transition()` function, so a field failure could be reproduced as a sequence rather than
  guessed at. On embedded products, the debugging cost of implicit state is paid every release.
- **24-hour aging automation.** Long-run stability testing became a scripted, repeatable job
  instead of a manual overnight ritual — which is what made intermittent field faults reproducible
  at all.

**Outcome.** Shipped to **mass production**. When the contract stopped at firmware, I built the Go
server and the Flutter companion application myself and closed the product: one protocol served by
two interchangeable backends — AWS IoT for connected deployments, a local mTLS broker for closed
networks — with **the firmware shipping unmodified in both**. Multi-hub fan-out was verified on
real hardware, with shadow mirroring under monotonic versioning.

**Why this is BSP-adjacent.** The part I want on the record is the last clause: the same firmware
binary served two completely different backends because the boundary was drawn in the right place.
That is the same discipline a BSP needs when one kernel and one rootfs have to serve several boards.

# 2. Cross-architecture port and board HAL — ARMv7/glibc → RISC-V/static musl

**Problem.** The next-generation hub had to leave a comfortable target — ARMv7 with glibc and a
vendor-provided sysroot — for RISC-V (SG2000) on **statically linked musl**. A vendor sysroot is a
soft floor: it hides which dependencies are really yours until the floor is removed.

**What I did.**

- Moved the port target and made the userland static, which forced every implicit dependency on the
  vendor sysroot into the open.
- **Extracted a board HAL** so the hub core no longer knows what board it runs on. Hardware
  differences stopped leaking into product logic.
- Delegated Zigbee transport to Zigbee2MQTT on an EFR32MG24 rather than keeping a second radio
  stack in-tree.
- Went device-agnostic by **removing seven hardcoded device-type handlers** — the ones that had
  accumulated because there was no boundary to put them behind.

**Second data point on the same muscle.** One Go codebase for an open-source Matter hub runs on
**RPi5 + Hailo-8 NPU under Yocto** and on **RK3576 under Android**, sharing the great majority of
its source across the two deployments — BLE commissioning for Matter/Thread through a bridge, OTBR
integration. A related customer engagement delivered a Matter wallpad on RK3576 + Android 15 with
an ESP32-H2 as Thread RCP, built against the AOSP-native CHIP C++ SDK with `ot-daemon`, packaged as
a versioned Android SDK into the customer's own namespace. The work is open at
`github.com/junghan0611/homeagent-config`.

**Why this maps to a BSP posting.** "Configure for new hardware platforms" and "customize the
kernel and root file system" are, in practice, the question of *where the board stops and the
product begins*. I have drawn that line twice under real constraints — once across an ISA change,
once across two operating systems.

# 3. Kernel-layer research, and performance treated as measurement

**Research (Sungkyunkwan University, Distributed Computing Lab, 2018–2022).** Non-volatile-memory
filesystems and NUMA lock performance in virtualized environments, with an exchange research period
at Virginia Tech's COSMOSS Lab. This is kernel-layer work — filesystem behaviour and lock
contention — and it is the reason low-level discussion is familiar ground rather than new
vocabulary. **It is research, not a shipped driver, and I present it as such.**

**Performance as a habit, not a claim.** In a separate domain I diagnosed a production latency
regression by instrumenting rather than guessing — CPU state, boot time, resident memory — and
isolated a cold-persisted registry interacting with a repair command as the cause. The fix itself
was an **upstream release**, not mine; what was mine was the diagnosis, the decision to roll
forward to the *latest known-good* version rather than the last quiet one, and the written
promotion policy that came out of it: no two-version jumps, stage on a non-production target for at
least 24 hours, a single stalled session is a reason to pause. That policy is the same shape as a
BSP team's release discipline, and I would rather be credited for it than for somebody else's
performance delta.

**Award.** Prime Minister's Award, Korea Software Competition (2010), for mobile virtualization
software.

# 4. NEMO-UX — the first time I took Linux to a product

**Co-founder.** Built a Linux-based large-format touch display OS for commercial and education
markets, and ran the **full embedded product lifecycle**: hardware integration, OS customization,
application development, and mass production. The venture ran 2013–2017 including the preparation
period alongside doctoral coursework; the incorporated company operated 2015.08 – 2017.08.

The startup failed. What did not fail is the habit of taking a product from silicon to shipping,
and knowing which parts of that path are where the schedule actually dies — bring-up on a board
that is not finished yet, a kernel or image that has to be reproducible for a factory, and a
hardware team that needs an answer before the next build.

# 5. Boundaries — stated once more, plainly

- **Bootloader (U-Boot, LK): no porting experience.**
- **Device trees: I have not authored or optimized them for a new platform.**
- **Production kernel drivers: no.** Kernel-layer work in my history is research (filesystem, locks).
- **Assembly: no working experience.** My low-level languages are C and Zig.
- **JTAG / ETM / SWD: not in my practice.** My hardware debugging has been at the level of aging
  automation, real-device fan-out, protocol tracing and firmware instrumentation.
- **Vendor BSP porting to a new SoC: no.** I have built products on top of vendor BSPs and moved a
  product across an ISA boundary; that is not the same thing.
- **Silicon validation and failure analysis: no.** Chip verification in a fabless flow is adjacent
  to what I have done, not something I have owned.
- **Hypervisor, virtual platform, SoC emulator, ASPICE: no.**

I would rather be evaluated on the port, the board HAL, and the shipped products than be given
credit for the eight lines above. If the team needs a bootloader specialist first, this is not the
right match and I would rather both of us know that at the paper stage.

# 6. How to check any of this

Public repositories, commits and dated records carry the claims that can be carried publicly.
Employment work is marked as employment work and is not linked.

| What | Where |
|---|---|
| Matter hub across two boards (Yocto / Android) | `github.com/junghan0611/homeagent-config` |
| Declarative NixOS across four machines | `github.com/junghan0611/nixos-config` |
| Merged upstream patches (Emacs terminal on libghostty-vt) | `github.com/dakra/ghostel` PR #343, #510 |
| Contributed backend to an agent runtime | `github.com/junghan0611/entwurf` PR #40 |
| Working corpus, dated and live | `agenda.junghanacs.com` · `notes.junghanacs.com` |
