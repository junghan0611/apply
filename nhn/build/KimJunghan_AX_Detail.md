# 이 문서를 읽는 법

이 문서는 두 PDF(역량·성과 기술서 / 포트폴리오)에서 판면상 덜어낸 구현 세부·파일 경로·실패 사례·설계 판단·검증 URL을 회수한 **원문입니다**. 세 갈래로 쓸 수 있습니다.

1.  **사람(채용 검토자):** 각 프로젝트의 「핵심 판단」과 「Tech Interview anchors」만 읽어도 깊이를 확인할 수 있습니다.
2.  **에이전트(자동 탐색):** 프로젝트마다 공개 저장소 URL과 파일 경로가 있어, 실제 코드로 내려가 주장을 검증할 수 있습니다.
3.  **T인터뷰(라이브 코딩, Claude Code):** 「Tech Interview anchors」는 제가 그 자리에서 열어 설명할 파일·테스트·설계 판단의 진입점입니다.

**공개/비공개 경계.** `[공개]` 는 클릭 가능한 저장소·PR·라이브 URL로 검증됩니다. `[사내]` 는 회사 코드·고객 데이터라 공개 URL이 없고, 구조와 판단만 서술하며 식별 정보는 비워 둡니다. 원시 고객 식별자·자격증명은 이 문서에 없습니다.

# 프로젝트 1 — 사내 업무 시스템 AX 접점 \[사내\]

**목표.** 대규모 스마트홈 IoT 운영 시스템(헤이홈)을 교체하지 않고, 도메인 오너가 자기 데이터를 자기 언어로 묻고 원자료까지 역추적하게 만드는 읽기 전용 에이전트 접점.

**구조(텍스트).**

- 업무 원천: IoT 디바이스 로그 · 상담(VOC) · 사내 문서 · 클라우드/Kafka 이벤트.
- 서빙 계층: 임베딩 서빙 + 리랭킹 서빙(GPU·컨테이너), 문서 임베딩(2,945건, pgvector), n8n 40+ 노드 수집.
- 읽기 전용 워크벤치: `incidentcli` , `voscli` — 자연어 질의를 실데이터로 잇되 mutation 금지.
- 도메인 워크벤치: 운영자/QA가 자연어로 묻고, 근거를 개별 원본 id까지 역추적.

<figure>
<img src="images/company-ax-arch.png" />
<figcaption>사내 AX 접점 아키텍처 (동일 구조를 위 텍스트로도 서술)</figcaption>
</figure>

## incidentcli — 운영 장애·VOC→디바이스 추적 워크벤치 \[사내\]

- **역할:** 운영 장애와 VOC→QA 디바이스 추적을 **하나의 KST 단일 시간축으로** 회수·정렬하는 Clojure/JVM CLI.
- **설계 판단:** (a) 모든 외부 호출 **읽기 전용** — 덤프를 저장하지 않고 살아 있는 원본에서 읽는다. (b) 수집기 출력은 \*SPEC envelope로 검증\*(collector envelope SPEC v0.4.0, incident record SPEC v0.1.0). (c) 인시던트 기록은 **append-only**. (d) 9개 수집기: Slack alert, API monitor DB, git trace, Kafka bizapi, cybertron, CI/CD, CloudTrail, cybertron DMS, Tuya devlog.
- **추적 사슬:** `phone/email → uid → device → session/event/status` . op-cube 콘솔 device-log가 본류, StarRocks 런타임 미러는 집계, DMS는 raw row.
- **보안 경계(설계):** 자격증명(ClientID/Secret·쿠키)은 **에이전트가 취급하지 않는다** — 사람이 직접. mutation/execute(freeze/delete/transfer/reset) 경로 금지. 원시 `uid/devId/phone/email` 은 문서·커밋 금지, 표준입력(`-`) seam으로만. 쿠키 3종(DMS/op-cube/StarRocks)을 세션별로 분리.
- **실패에서 배운 것:** "단일 SSO가 전부 커버"라는 가정을 폐기하고 세션별 쿠키를 분리. 2,749 테이블 blind matrix 금지 — seam-bounded catalog crosswalk로 한정.
- **Tech Interview anchors \[사내, 라이브 코딩 시 시연\]:** SPEC envelope EDN 스키마 검증 · KST 정규화 로직 · 읽기 전용 seam(PII stdin) · collector dispatch. (공개 아날로그: voscli 아래 EDN transform 패턴과 동형.)

## voscli — 운영팀 VOC 분석 워크벤치 \[사내\]

- **역할:** 운영팀이 매일 보는 상담 데이터 위의 **양적 귀추(quantitative abduction) 워크벤치** (Clojure).
- **설계 판단:** (a) CLI core가 본체(도메인 SSOT — EDN transform·검증·이상 검출·리포트 생성), 스킬은 얇은 표면. (b) 숫자의 **단위·기간·포함정책을 고정**. (c) 모든 근거를 개별 **chat-id까지 역추적**. (d) ChannelTalk 인입은 **adjacent track으로** 본체에서 격리.
- **운영 성과:** 1년치 상담 원자료(330일, 2025-07 ~ 2026-05)를 backfill해 운영자·봇 워크스페이스가 `git pull` 만으로 사용. v0.6.2 = chat URL 링크 + responder by-count + safety 신호 + 응답시간(FRT/ART). **운영자 일상 사용 진입.**
- **협업 루프(사람):** 운영팀 상담 고통 → 개발 가능한 요구로 번역 → 제품·개발과 경계 합의 → 워크벤치 제공 → 피드백을 다시 데이터·이슈로. Slack `#report_상담분석` 을 ground truth로 회수.
- **Tech Interview anchors \[사내\]:** `voscli.core` EDN 파이프라인 · anomaly 검출 · responder by-count 집계 · 응답시간 계산.

**이 프로젝트의 공개 아날로그.** 사내 임베딩·검색 감각은 공개 저장소 andenken(프로젝트 3)에서 그대로 검증됩니다 \[1\]. 벡터 저장은 pgvector \[2\].

# 프로젝트 2 — 실사용 에이전트 플랫폼 운영 (OpenClaw)

**목표.** 실사용 트래픽이 걸린 에이전트 런타임을 약 5개월간 20+ 버전 사이클로 운영하며, 회귀를 계측·롤백하고 정책을 문서화.

**맥락.** 업스트림은 1인 유지 프로젝트이고 조직에 업스트림 담당자가 없음 → "버전 올리기 = 릴리즈 의미를 내 환경으로 번역하기". Oracle Cloud ARM(aarch64) · Docker · 메신저 다중 채널.

## 인시던트 ① — 계측 후 정확한 판으로 롤백 \[운영 기록\]

- **증상:** 두 버전 점프 후 응답 latency 급증, `stuck session: state=processing age=164s` .
- **계측:** 게이트웨이 단일 스레드 \*CPU 102% 회전\*(자식 프로세스 없음), 부팅 \*88초\*(정상 11초).
- **가설 배제:** fresh boot에서도 재현 → operator config 오류가 아님(TTS config 추가 전 발현).
- **근본 원인 가설:** 콜드 영속 플러그인 레지스트리 ↔ 자동 수정 도구 충돌 → 레지스트리 rebuild가 활성 플러그인 7→3 축소 → 첫 inbound가 hot path 한복판에서 의존성 설치 트리거.
- **롤백 타깃 선택(핵심 판단):** 한 단계 아래(4.22)가 아니라 **이미지 생성이 기존 인증(flat-rate)으로 라우팅되는 마지막 정상 판으로**. "최신 고집 안 함"과 "아무 데나 롤백"은 다르다.
- **검증:** ready 11.3초, idle CPU 0.07%, stuck-session 진단 0. **비용:** 운영자 주의력 5시간.

## 인시던트 ② — 릴리즈 노트에서 정공법 수정 식별 \[운영 기록\]

- 다음 판 재시도 → 10분 만에 동일 인시던트 재현 → 릴리즈 노트를 **"내 증상의 원인을 정면으로 고친 줄"** 로 읽음.
- 식별한 두 줄: 런타임 프리로드를 설정된 플러그인 id로 한정 / 플러그인 도구 서술자 캐시. → 중간 판 건너뛰고 직행.

<figure>
<img src="images/openclaw-ops.png" />
<figcaption>인시던트 ② 전후 (동일 수치를 아래 표로)</figcaption>
</figure>

| 지표                   | before  | after                   |
|------------------------|---------|-------------------------|
| 부팅                   | 45.4초  | 7.3초 → 하드닝 후 5.8초 |
| 메모리                 | 816 MiB | 246 MiB                 |
| 핫패스 의존성 스테이징 | 발생    | 0                       |
| 유령/정체 세션         | 72      | 16                      |

- **하드닝:** 컴파일 캐시 + 재기동 억제.
- **정책 명문화:** 두 버전 건너뛰기 금지 · wait-and-watch · 비프로덕션 24h+ 스테이지 후 승격 · `stuck session` 한 줄도 배포 중단 · 응답성이 SLO(체감 latency=P0).

## 판단의 규율 \[운영 기록\]

진단 도구의 보안 권고(자격증명 권한/이미지 모델 교체/멀티유저 위험)를 우리 배포 맥락에서 **거짓 양성으로 판정하고 미적용**. 자동 수정(`doctor --fix`)도 설정 재작성 위험 때문에 미사용. → "이유 모른 채 따르면 위험"을 메모리로 저장. **AX 도입 실패의 전형(도구 권고 맹종)에 대한 실증적 반례.**

**핵심 증거.** 이 운영이 낳은 공개 계층: \[1\], \[3\], \[4\]. 봇 기억이 담긴 런타임 설정은 \[사내·비공개\].

# 프로젝트 3 — 에이전트 메모리·RAG (andenken) \[공개\]

저장소: \[1\].

**구조 — 메모리 3축.**

- `active recall` : 답변 전 차단형 리콜, 타임아웃 경계, graceful degrade. 이 리포 밖의 하네스 계층에서 구현.
- `embedding` : 벡터 + BM25 하이브리드, **점수 정규화**. 세션·공개 가든 두 트랙. (구현·운영 중.)
- `dream` : 야간 통합, 기억 증류. (미구현, 별도 로드맵.)

**구현 스펙.** LanceDB \[5\] · Qwen3-Embedding-8B 4096차원 \[6\] · 하이브리드 리트리벌(vector + FTS, score 정규화, BM25 \[7\]) · 한↔영 교차 질의는 별도 CLI(형태소 분석 + 태그 매핑) 경유 · recall tracking(무엇이 다시 불려 나왔는가 = 기억 통합의 입력).

**설계 판단.** RAG를 "청킹·임베딩·벡터DB"로 뭉치지 않는다 — 검색은 세 축 중 하나. 언제 리콜을 **차단형으로** 걸 것인가와 무엇을 **증류할** 것인가가 나머지 둘. 파인튜닝 중심이 아니라 임베딩 서빙·리랭킹·검색 품질·프롬프트 설계 축.

**Tech Interview anchors.** 하이브리드 리트리벌의 \*점수 정규화\*(서로 다른 스케일의 vector 유사도와 BM25 점수를 합치는 방식) · 세션/가든 두 트랙 임베딩 경로 · dictcli 교차 질의 확장. 실패 사례로 논의할 것: 정규화 없이 합칠 때의 랭킹 왜곡.

# 프로젝트 4 — 멀티 하네스 개발 워크플로 (entwurf + forge-config) \[공개\]

저장소: entwurf \[3\] · forge-config \[4\].

## entwurf — 하네스 간 디스패치·연속성

- **역할:** Claude Code·Codex 등 하네스가 상대의 인증·대화록·런타임을 소유하지 않고 **정체성만으로 서로를 호출하게** 하는 얇은 기층 \[8\].
- **전개(공개 커밋):** harness-first setup(`f31367d`) → provider를 claude-agent-acp bridge로 전환(`50328a4`) → dual ACP backend(`1731865`) → send-is-throw 메시징 계약을 tool·AGENTS 수준으로 성문화(`8e98872`) → gemini 세 번째 backend(`eb4c973`).
- **설계 판단:** "send is throw" — 메시지 전송은 응답을 기다리지 않는 fire-and-forget이 기본. 정체성 전달과 provider 추상화가 핵심.
- **수용(reception):** 외부 개발자가 Snowflake Cortex Code ACP 백엔드 기여를 열었다 \[9\]. **내가 그은 확장 경계에 제3자가 실제로 기여한 기록.**
- **Tech Interview anchors.** provider abstraction과 세션 identity 전달 · ACP backend bridge 구조 · send-is-throw 계약.

## forge-config — 검토 가능한 개발 루프·sweeper

- **운영 루프:** 도메인 오너가 도메인 봇과 대화 → 요구·버그 감지(봇 또는 sweeper) → 라벨+소스 컨텍스트로 Forgejo 이슈 생성 \[10\] → `forgebot` 이 웹훅으로 깨어남 → owner agent에게 **읽기 전용 1차 리뷰** 요청 → reality check·risk·scope·우선순위 반환 → 리뷰 기록·triage 종료 → 사람이 정렬된 백로그를 보고 focused batch로 구현.
- **하지 않기로 한 것(non-goal):** 자동 코딩 공장 아님 · 운영 대시보드 제품 아님 · 무엇을 구현할지 사람이 정하는 일 대체 아님. `forgebot` 은 **dispatcher/recorder이지 implementer가 아니다.**
- **상태 권위(설계 핵심):** 템플릿 마커가 schema·report<sub>id</sub>·session<sub>key</sub>·issue<sub>updatedat</sub>·lifecycle 라벨·model·설정 커밋을 기록. 목적은 하나 — **세션 메모리와 웹훅 replay가 현재 Forge 상태를 절대 이기지 못하게.** 에이전트 기억보다 durable store가 권위.
- **실증 착지:** auto-fix v0 GREEN(`sandbox#13` , `voscli#15` — 라벨 감지→리포트→완료 전이, **replay/idempotency 스모크에서 리포트 중복 0**). v1 seed GREEN(`voscli#14` bounded workspace guard patch, `voscli#16` rg no-match를 nonfatal sweep case로, `voscli#17` post-fix 회귀 통과).
- **책임 경계:** 상류 런타임은 transport/auth/model/gateway/lifecycle을 "봇이 깨어날 때까지" 소유, forge-config는 lifecycle protocol·auto-fix semantics·sweeper semantics·validation loop·follow-up 규칙 소유.
- **Tech Interview anchors.** sweeper의 snapshot drift guard · deterministic mutation gate · replay 멱등성(리포트 중복 방지) · marker 기반 상태 권위.

**상류 수용.** 제 코드가 남의 프로젝트에 받아들여진 기록 \[11\], \[12\].

# 프로젝트 5 — Linux·Backend·제품 배경

- **대형 터치 디스플레이 Linux 플랫폼(공동창업, 양산):** Yocto 기반 BSP \[13\], 다중 사용자 OS. "펌웨어→제품"의 첫 사례.
- **스마트홈 디바이스 양산:** Zigbee/Wi-Fi 펌웨어 → Go 서버 → Flutter 앱. 연결형=AWS IoT, 폐쇄망=로컬 백엔드가 같은 프로토콜. 임베디드·엣지 경험은 공개 저장소로도 \[14\].
- **사내 R&D(durable-iot-migrate) \[사내\]:** IoT 자동화 레시피 이관을 durable execution으로 재정의(Temporal·Saga·의미 보존 검증·Doltgres 감사) \[15\], \[16\]. Clojure Expr IR로 플랫폼 차이를 어댑터 경계로 격리.
- 재현 가능한 Linux 기반 전체: \[17\], \[18\].

# 정직한 경계

- Java/Spring 직접 경험을 Go/Clojure 경험으로 바꾸어 쓰지 않는다.
- BMAD 사용 경험 없음 — 같은 문제층의 독립 구현(forge-config)과 차이를 밝힌다 \[19\].
- Tailwind 직접 경험 없음 — React/Preact/Lit + 디자인 토큰으로 대체.
- 파인튜닝(LoRA) 중심 아님 — 임베딩 서빙·리랭킹·검색 품질·프롬프트 설계가 강점축.
- OpenClaw는 상류 소프트웨어 — 내 것은 그 위의 운영층·메모리 계층·개발 루프.
- 교육: 정규 교육과정 운영보다 가이드·데모·온보딩·인계·후속 지원 중심.
- 사내 코드·식별 가능한 운영 데이터·원시 개인정보는 이 문서에 없다.

# 공개 검증 표면

- 에이전트 디스패치·연속성 — \[3\] (외부 기여 \[9\])
- 세션·지식 메모리(RAG) — \[1\]
- 검토 가능한 개발 루프 — \[4\]
- 재현 가능한 Linux 기반 — \[17\]
- 임베디드·엣지 — \[14\]
- 상류 수용 — \[11\], \[12\]
- 공개 지식·문서 체계 · 라이브 통계 — \[20\], \[21\]

# 참고자료

<div id="refs" class="references csl-bib-body" entry-spacing="0">

<div id="ref-repo-andenken" class="csl-entry">

<span class="csl-left-margin">\[1\] </span><span class="csl-right-inline">J. Kim, “andenken — 세션·지식 시맨틱 메모리 (벡터+BM25 하이브리드)”. 2026년. Available at: <https://github.com/junghan0611/andenken></span>

</div>

<div id="ref-pgvector" class="csl-entry">

<span class="csl-left-margin">\[2\] </span><span class="csl-right-inline">pgvector, “pgvector — Vector Similarity Search for Postgres”. 2025년. Available at: <https://github.com/pgvector/pgvector></span>

</div>

<div id="ref-repo-entwurf" class="csl-entry">

<span class="csl-left-margin">\[3\] </span><span class="csl-right-inline">J. Kim, “entwurf — 하네스 간 디스패치·연속성 기층”. 2026년. Available at: <https://github.com/junghan0611/entwurf></span>

</div>

<div id="ref-repo-forge-config" class="csl-entry">

<span class="csl-left-margin">\[4\] </span><span class="csl-right-inline">J. Kim, “forge-config — 검토 가능한 개발 루프·sweeper”. 2026년. Available at: <https://github.com/junghan0611/forge-config></span>

</div>

<div id="ref-lancedb" class="csl-entry">

<span class="csl-left-margin">\[5\] </span><span class="csl-right-inline">LanceDB, “LanceDB — Open-source Vector Database”. 2025년. Available at: <https://lancedb.github.io/lancedb/></span>

</div>

<div id="ref-qwen3-embedding" class="csl-entry">

<span class="csl-left-margin">\[6\] </span><span class="csl-right-inline">Qwen Team, Alibaba, “Qwen3 Embedding: Advancing Text Embedding and Reranking”. 2025년. Available at: <https://qwenlm.github.io/blog/qwen3-embedding/></span>

</div>

<div id="ref-bm25-robertson" class="csl-entry">

<span class="csl-left-margin">\[7\] </span><span class="csl-right-inline">S. Robertson 와/과 H. Zaragoza, “The Probabilistic Relevance Framework: BM25 and Beyond”. 2009년. Available at: <https://doi.org/10.1561/1500000019></span>

</div>

<div id="ref-acp-spec" class="csl-entry">

<span class="csl-left-margin">\[8\] </span><span class="csl-right-inline">Zed Industries, “Agent Client Protocol”. 2025년. Available at: <https://agentclientprotocol.com/></span>

</div>

<div id="ref-pr-entwurf-40" class="csl-entry">

<span class="csl-left-margin">\[9\] </span><span class="csl-right-inline">External contributor, “entwurf PR \#40 — Snowflake Cortex Code ACP 백엔드 기여”. 2026년. Available at: <https://github.com/junghan0611/entwurf/pull/40></span>

</div>

<div id="ref-forgejo" class="csl-entry">

<span class="csl-left-margin">\[10\] </span><span class="csl-right-inline">Forgejo, “Forgejo — Self-hosted Lightweight Software Forge”. 2025년. Available at: <https://forgejo.org/></span>

</div>

<div id="ref-pr-ghostel-343" class="csl-entry">

<span class="csl-left-margin">\[11\] </span><span class="csl-right-inline">J. Kim, “ghostel PR \#343 — 상류 프로젝트에 받아들여진 기여”. 2026년. Available at: <https://github.com/dakra/ghostel/pull/343></span>

</div>

<div id="ref-pr-ghostel-510" class="csl-entry">

<span class="csl-left-margin">\[12\] </span><span class="csl-right-inline">J. Kim, “ghostel PR \#510 — 상류 프로젝트에 받아들여진 기여”. 2026년. Available at: <https://github.com/dakra/ghostel/pull/510></span>

</div>

<div id="ref-yocto" class="csl-entry">

<span class="csl-left-margin">\[13\] </span><span class="csl-right-inline">Yocto Project, “The Yocto Project — Embedded Linux Build System”. 2025년. Available at: <https://www.yoctoproject.org/></span>

</div>

<div id="ref-repo-homeagent-config" class="csl-entry">

<span class="csl-left-margin">\[14\] </span><span class="csl-right-inline">J. Kim, “homeagent-config — 임베디드·엣지 에이전트”. 2026년. Available at: <https://github.com/junghan0611/homeagent-config></span>

</div>

<div id="ref-temporal-durable" class="csl-entry">

<span class="csl-left-margin">\[15\] </span><span class="csl-right-inline">Temporal, “Durable Execution”. 2025년. Available at: <https://assets.temporal.io/durable-execution.pdf></span>

</div>

<div id="ref-saga-pattern" class="csl-entry">

<span class="csl-left-margin">\[16\] </span><span class="csl-right-inline">C. Richardson, “Pattern: Saga”. 2023년. Available at: <https://microservices.io/patterns/data/saga.html></span>

</div>

<div id="ref-repo-nixos-config" class="csl-entry">

<span class="csl-left-margin">\[17\] </span><span class="csl-right-inline">J. Kim, “nixos-config — 노트북·서버·ARM 선언적 관리”. 2026년. Available at: <https://github.com/junghan0611/nixos-config></span>

</div>

<div id="ref-nixos" class="csl-entry">

<span class="csl-left-margin">\[18\] </span><span class="csl-right-inline">NixOS, “NixOS — Declarative Builds and Deployments”. 2025년. Available at: <https://nixos.org/></span>

</div>

<div id="ref-bmad-method" class="csl-entry">

<span class="csl-left-margin">\[19\] </span><span class="csl-right-inline">BMad Code, “BMAD-METHOD: Breakthrough Method for Agile AI-Driven Development”. 2025년. Available at: <https://github.com/bmad-code-org/BMAD-METHOD></span>

</div>

<div id="ref-live-garden" class="csl-entry">

<span class="csl-left-margin">\[20\] </span><span class="csl-right-inline">J. Kim, “Digital Garden — 공개 지식·문서 체계 (notes.junghanacs.com)”. 2026년. Available at: <https://notes.junghanacs.com></span>

</div>

<div id="ref-live-agenda-stats" class="csl-entry">

<span class="csl-left-margin">\[21\] </span><span class="csl-right-inline">J. Kim, “Agenda 라이브 통계 API (/api/stats)”. 2026년. Available at: <https://agenda.junghanacs.com/api/stats></span>

</div>

</div>
