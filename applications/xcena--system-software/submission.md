# 제출 기록 — XCENA (엑시나) / System Software 계열

| 항목 | 값 |
|---|---|
| 상태 | **held** (목록만 정리 · 지금은 내지 않는다 — GLG 판단) |
| 지원일 | — |
| 경로 | **그리팅** (자체 도메인 `xcena.career.greetinghr.com`) — 가입 불필요 |
| 첨부 컷 | 미정 (되살릴 때 결정) |
| 회사 보드 | https://xcena.career.greetinghr.com/ko |
| 근무지 | 경기 성남시 분당구 판교역로241번길 20, 미래에셋벤처타워 8층 |

> **한 공고의 지원 건이 아니다.** 회사 하나를 통째로 훑어 `JD.md` 에 23건 지도와 상위 6건
> 원문을 떠 둔 폴더다. 되살릴 때 다시 긁지 않는다.

## 왜 지금 내지 않는가 (2026-07-28 GLG)

> "perf ftrace 이런건 커널 드라이버 작업할때 파일시스템 튜닝할때 하는거야. 별로 관심은 없다.
> 일단 폴더 두고 목록만 정리해두자. **너무 시스템 가니까 재미없어 보인다.**"

**적합도가 낮아서가 아니다 — 지향이 아니어서다.** 이 구분을 남겨 둔다. 나중에 이 폴더를
다시 열 사람이 "떨어질까 봐 안 냈다"로 오독하면 안 된다.

기술적으로는 오히려 **다른 어느 케이스보다 문이 넓다**. 아래 「대는 카드」가 그 근거다.

## 대는 카드 — 왜 이 회사가 열려 있었나

이력서에 이미 있는 두 줄이 이 회사의 진입장벽 그 자체다.

- **성균관대 분산컴퓨팅랩 (2018–2022)** — *비휘발성 메모리(NVM) 파일시스템*, *가상화 환경
  NUMA lock 성능* 연구 + Virginia Tech COSMOSS Lab 교환연구
- **NEMO-UX (2013–2017)** Linux OS를 실리콘에서 양산까지 · **현직 (2025.06–)** Zig 펌웨어
  양산, RISC-V(SG2000) static musl 포팅, board HAL 추출

XCENA 공고의 우대요건이 `DRAM/NVM Hybrid 또는 Tiered Memory 시스템`,
`CXL·NUMA 등 메모리 아키텍처 이해`, `Device Memory Allocator (NUMA topology, CXL 메모리 계층
고려)` 다. **다른 지원 컷에서는 쓸 자리가 없던 대학원 축이 여기서만 정면으로 쓰인다.**

## 되살린다면 — 순서까지 정해 둔다

| 순위 | 공고 | ID | 컷 | 근거 |
|---|---|---|---|---|
| 1 | System Software Engineer, **Device Runtime & SDK** | 110622 | Embedded | **필수 4개를 전부 넘는 유일한 자리.** Zig type-safe FFI 로 legacy C Zigbee SDK 를 감싼 것이 ABI 경계, AOSP-native CHIP C++ SDK 를 버전 관리되는 AAR 로 고객 네임스페이스에 딜리버리한 것이 「SDK 패키징·배포 자동화」 정면. 우대의 CXL·NUMA 이해 = 대학원 NUMA lock 연구 |
| 2 | Software Engineer, **Vector Search** | 167324 | AI Engineer | 우대 `pgvector RAG 파이프라인 구축·성능 최적화` = 현직 pgvector 2,945 임베딩 + 임베딩·리랭킹 직접 서빙. `andenken`(LanceDB 하이브리드 vector+FTS)이 담당업무의 「하이브리드 검색」 정면 |
| 3 | Software Engineer, **KV Cache Infrastructure** | 224146 | AI Engineer | **문턱이 가장 낮다**(Python·C++ + LLM/KVCache 기본 이해). vLLM/SGLang·CUDA 실경험은 없음 |
| 4 | Software Engineer, **Data Analytics Engine** | 110619 | Software Engineer | 필수가 `Rust 또는 C/C++` 이라 통과. Rust 무경험, Zig·Go·Clojure·C 다언어 축이 명분 |
| 5 | **Embedded system BSP 개발** | 110624 | Embedded | 임베디드 정면이지만 **부트로더 직접 개발·Secure Boot 가 없다**. 연차 `5년 이상`은 NEMO-UX 4년 + 현직 합산 |

**막힌 것 3건**(224152 FTL 구현 필수 · 110623 PCIe/NVMe 펌웨어 5년 · 147043 장치보안 3년)은
`JD.md` 하단에 이유와 함께 적어 두었다.

## 되살릴 때 먼저 할 일

1. **자기소개서 한 벌.** 이 회사는 **전 포지션이 「이력서 + 자기소개서」**를 받는다. 지금까지
   연 케이스 대부분이 PDF 한 장으로 끝났던 것과 다르다. 대신 회사가 하나이므로 **한 벌을 쓰면
   여러 공고에 재사용된다.**
2. 그리팅 폼의 `docsInfo`·`questionnairesInfo` 를 `boards.py body greeting:xcena <ID>` 로
   다시 확인한다(서술형 문항은 2026-07-28 시점 없음).
3. 51명 규모다. **리퍼럴 무게가 크다** — GLG 의 시스템 쪽 선후배 축이 폼보다 빠를 수 있다.

## 낸 것

- [ ] 이력서 PDF — 미정
- [ ] **자기소개서 — 전 포지션 필수. 아직 없다**

## 이후 기록

- [2026-07-28] 건 생성. `boards.py list greeting:xcena` 로 **23건 전량** + 상위 6건 본문 확보.
  LinkedIn 판은 12건만 보였고 **연차 요건이 잘려** 나왔다 — 그리팅 원문이 SSOT다.
- [2026-07-28] **`held`.** GLG: "너무 시스템 가니까 재미없어 보인다." 목록만 남기고 로봇 축으로
  방향 전환.
