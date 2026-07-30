# Cover Letter — Bear Robotics / Systems Software Engineer (Linux Platform)

⚠ **슬롯 미실측.** Breezy HR 은 보통 `Cover Letter` 칸을 두지만 이 워크스페이스는 열어 봐야
안다. 있으면 아래 「붙여넣을 본문」을 그대로 붙이고, 없으면 **버리지 않는다** —
전형이 서류 → HR Screening → **Peer Interview 3시간**이다. 그 3시간의 답 골격이 이 글이다.

- 언어: **영문.** 공고 첫 줄이 `English CV must be submitted.` 이고 보고 라인이 **미국**이다.
  붙일 이력서도 영문 Embedded 컷이다. **한글 서류를 만들지 않는다.**
- 길이: **474 단어**(`submit/cover-letter.txt` 실측). 서식이 없을 수 있으므로
  굵게·목록을 쓰지 않았다.
- 이 글의 심장은 **Nix 문단**이다. 공고는 Terraform 을 우대로 적었고 나는 그 실적이 없다.
  **다른 도구로 같은 곳에 도달했다**고 말하되, 없는 것은 한 문장으로 분명히 없다고 적는다.

---

## 붙여넣을 본문

The first line of your posting asks for an English CV. The rest of it asks for someone who can make a Linux platform hold still underneath other people's software. I have spent most of my career on the second problem.

At my first company, NEMO-UX, we built a Linux-based OS for large touch displays. The startup failed after four years. The habit of owning a system from the board up did not. Since then I shipped a Zigbee/Wi-Fi hub to mass production — gateway firmware in Zig, a deterministic state machine spanning the driver, protocol, and cloud layers — and then moved that same hub core from ARMv7/glibc with a vendor sysroot to RISC-V (SG2000) on statically linked musl, extracting a board HAL so the core no longer knows which board it runs on.

Your responsibilities read as three things: a standard environment for robot software, the infrastructure that deploys and manages it, and a device identity and access-policy layer. I have built the device-identity part of that third layer. The hub's cloud link runs behind two interchangeable backends — AWS IoT for connected deployments, a local mTLS broker for closed sites — so the same device identity remains valid whether or not the site has a route to the internet.

For the second, my answer is Nix rather than Terraform, and I would rather say that plainly than let it look like a match. I run four machines and seventeen Docker services declaratively, including a GPU cluster of three RTX 5080s on a 10G network. When something installs, I record the vcs_revision, the source-tree digest, and the binary SHA-256, because what is actually on that machine is the only question worth answering during an incident. That is the same instinct your posting calls package distribution and management; I reached it through a different toolchain. I have no Terraform track record. The daemons and CLIs around it are Go, Python, and Bash — small binaries other processes query, which is the shape your first required qualification describes.

On open source: two of my patches were merged upstream into dakra/ghostel, an Emacs terminal emulator built on libghostty-vt — pull requests 343 and 510, in someone else's repository, on their terms.

Where I am short. I have not worked with robots or ROS. I have not held Linux security infrastructure as a job; mTLS and Zero Trust are things I run, not things I was staffed on. My written English is daily work — I review pull requests in it and wrote this letter in it — but your reporting line is in the USA, and real-time meetings are a different skill. Fluent small talk is not my strength, and I would rather you know that now than after an offer.

My work is public and dated: github.com/junghan0611.

I would like to work on the layer the robots stand on.

---

## 왜 이렇게 썼는가 — 나중에 되물릴 때를 위해

1. **첫 문단이 공고의 첫 줄을 받는다.** `English CV must be submitted.` 를 인용하지 않고
   **읽었다는 사실만 남긴다.** 그리고 곧바로 직무 정의로 넘어간다 — 「다른 사람의
   소프트웨어 밑에서 리눅스 플랫폼이 가만히 있게 만드는 일」.
2. **창업 실패를 두 번째 문장에 놓았다.** 이력서 본문이 이미 그 순서다
   (`The startup failed; the habit ... did not.`). **실패를 먼저 말하고 남은 것을 말하는** 순서가
   이 사람의 서사 전체이고, 감추면 오히려 이력의 공백이 이상해진다.
3. **주요 업무 세 줄을 내가 다시 분류했다.** 「표준환경 · 배포 인프라 · 인증/접근정책」으로
   묶은 뒤 **셋 중 하나를 이미 했다**고 말한다. 공고를 재구성할 수 있다는 것 자체가 신호다.
4. **Terraform 을 정면으로 처리했다.** 우대 항목이고 실적이 없다. 「Nix 로 같은 곳에
   도달했다」를 먼저 말하고 **`I have no Terraform track record.` 한 문장으로 닫는다.**
   변명 없이 한 줄로 끝내는 것이 길게 둘러대는 것보다 강하다.
5. **`vcs_revision` · 소스트리 다이제스트 · SHA-256 을 그대로 적었다.** 이 건의 우대에
   「패키지 배포·관리」가 있는데, **무엇이 깔렸는지 되짚는 문제**로 번역해야 로봇 플릿과
   연결된다. 2만대가 돌아가는 회사에 이 문장은 추상어가 아니다.
6. **영어를 마지막 경계로 놓고 먼저 말한다.** 보고 라인이 미국이다. `FAQ.md` §6 의 입장을
   그대로 옮기되 **에이전트 통역 이야기는 뺐다** — 이 자리는 에이전트 직무가 아니라
   시스템 직무라 그 문장이 붙으면 초점이 흐려진다.

## 쓰지 않은 것 (의도적)

| 뺀 것 | 왜 |
|---|---|
| 에이전트·하네스·MCP 서사 | **이 건의 컷은 Embedded 다.** AIRS·Upstage 에서 쓰는 축을 여기 붙이면 지원자가 무엇을 하는 사람인지 흐려진다 |
| 로봇 산업에 대한 포부 | 로봇 경험이 없다고 같은 글에서 밝힌다. 없는 열정을 지어내면 §경계가 무너진다 |
| LG전자 계열 편입·2만대 같은 회사 수치 | 공고가 이미 말한 것을 되돌려주면 조사한 티만 나고 정보가 없다. **대신 그 규모를 전제로 한 문장**(인시던트·플릿)을 썼다 |
| 석사 학위 | 필수는 **학사**다. 넘는 것을 강조하면 오히려 자리에 안 맞는 사람처럼 읽힌다 — 이력서가 말한다 |

## ⚠ 제출 전 확인

- **Breezy 폼에 Cover Letter 칸이 있는지 본다.** 파일 업로드형이면 **평문 대신 PDF 를 요구할 수
  있다** — 그 경우 이 건은 **집(노트북) 축**이다(`md2pdf.sh`). 서버에서는 못 만든다.
- **이력서는 Embedded 컷.** Telechips · DEEPX BSP 와 **같은 파일**이라 업로드 직전 파일명 확인.
- ✅ **GPT 교열 반영 (2026-07-30)** — 한 곳이 **과장 위험**이었다.
  `I have built that third layer.` 는 공고의 「device identity **and access-policy** layer」
  전체를 만들었다고 읽히는데, 근거는 device identity + mTLS 뿐이라 **access-policy 전체를
  댈 수 없다.** → `I have built the device-identity part of that third layer.` 로 좁혔다.
  같은 문장의 `the same device identity holds` 도 `remains valid` 로 고쳤다(자연스러움).
  **경계를 스스로 밝히는 글에서 한 줄이 과장되면 나머지 정직함이 같이 의심받는다.**
  나머지 리듬·경계는 GPT 판정으로 「좋다」 — 사실 좌표는 `JD.md` §우대 대조표와
  `resume/body.org` 44·50·53·79·191·208행이 들고 있다.
