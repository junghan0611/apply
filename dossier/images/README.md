# dossier/images — 깊이 문서 도해 7장의 출처와 공개 판정

이 디렉터리의 PNG 는 `competency.org` · `portfolio.org` · `detail.org` 가 `[[file:images/…]]` 로
참조하는 도해다. 공개 전환(2026-08-27) 때 history 에서 제거됐다가(`docs/HISTORY-REDACTION.md`
§employer-diagram) **2026-10-15 에 건별 재검토를 거쳐 다시 들였다.** 무엇을 근거로 다시 들였는지가
이 파일의 내용이다.

- **도해는 개념도다.** 판단의 구조·경계·흐름을 그린 것이지, 비공개 배포나 운영 실적의 증거가 아니다.
  증거는 본문의 인용 번호와 공개 URL · 커밋이 쥔다.
- 생성 이미지라 그림 속 일부 글자가 뭉개져 있다. `entwurf-hero.png` 의 궤도 문구(ACP 를 흉내 낸
  글자열)가 그렇고, 그 글자는 사실 표기가 아니다. 품질 메모: 프로필 repo 판정표는 「지어내거나 뭉개진
  글자열」을 반려 조건으로 두지만, 이 한 장은 2026-10-15 GLG 가 수선판 PDF 를 직접 열어 보고 유지를
  승인했다(「괜찮아 어차피 다시 그리면」 — 코디 경유). 다시 그릴 때 고친다.
- 이용 조건은 `LICENSING.md` 가 정본이다. 이 README 는 방법 문서다.
- 이 목록 밖의 파일을 여기 두지 않는다. 공개 게이트도 이 일곱 경로만 예외로 둔다.

## 파일별 기록

바이트 동일성 기준은 2026-08-01 에 실제로 빌드한 깊이 문서 ODT 의 임베드(`Images/000N.png`)다.
아래 sha256 은 그 임베드와 이 디렉터리의 파일이 같다는 것을 2026-10-15 에 스트림 대조로 확인한 값이다.

| 파일 | 쓰이는 자리 | sha256 | 이 사본의 출처 | 공개 판정 |
|---|---|---|---|---|
| `company-ax-layer.png` | competency 그림 1 | `350948c911fafcf4b8ab676008bd98caed97654466e0ba7ef6ffe4f790728e5a` | 프로필 repo `apply/ax/images/` | 기존 cleared (2026-07-20) — 도구명 두 개(`voscli`·`incidentcli`)를 GLG 가 읽고 허용 |
| `company-ax-arch.png` | portfolio 그림 1 · detail | `4b1237da4a5da051d41292152f57d927de07ba62ba1f5ed6d014ccf1d25c2b46` | 프로필 repo `apply/ax/images/` | 기존 cleared (2026-07-20) |
| `openclaw-ops.png` | portfolio 그림 2 · detail | `61937c8f64d5bfdad73bad22eb19dd0022e2f19fd66627dbae72ea29235c1917` | 프로필 repo `apply/ax/images/` | 기존 cleared (2026-07-20) |
| `andenken-rag.png` | portfolio 그림 3 | `9de8badf239dcaa6c17856b218c5928393e67d477eba35603af1556800ec6154` | 프로필 repo `apply/ax/images/` | 기존 cleared (2026-07-20) — **조건: 캡션이 반투명 계층(DREAM ROADMAP)을 미구현이라고 말해야 한다** |
| `entwurf-hero.png` | portfolio 그림 4 | `a71189bd8d7cff5ac65a87e638b5270c8336e3476f1f776817ff32644bfa72f8` | 08-01 ODT 임베드에서 추출 | 2026-10-15 신규 검토 · GLG 가 수선판 PDF 를 직접 열람하고 유지 승인 — 개념 일러스트, 2026-07 판 entwurf README 대표 그림(현재 대표 그림과 다름) |
| `platform-lineage.png` | portfolio 그림 5 · detail | `8abede6021ec458ea68c8a7113707fd964a216c9fbabed09362ee65d7df0229f` | 08-01 ODT 임베드에서 추출 | 2026-10-15 신규 검토 — socket·mailbox·native push 레일과 durable state 의 2026-07 시점 개념도 |
| `product-stack.png` | portfolio 그림 6 · detail | `0a81f8cbdb9821ba8cedbe18b77170d752dcba0257d795f564ffdcb3c52e1d30` | 프로필 repo `apply/ax/images/` | 기존 cleared (2026-07-20) — 그림 속 `GLGMAN` 서명은 공개 대체 이름이다. 캡션에서 언급하지 않는다 |

- **기존 cleared** — 프로필 repo `junghan0611/junghan0611` 의 `apply/ax/images/README.md` 공개 판정표
  (file · depicted claim · visible labels checked · factual source · cleared by / date · status). 그 표의
  다섯 행이 위 다섯 파일이다. 판정자는 행마다 적혀 있다 — 다섯 장 모두 Opus 가 열어 읽었고
  (2026-07-20), `company-ax-layer.png` 의 도구명 두 개는 GLG 가 읽고 공개를 결정했다. 이 저장소는
  그 판정을 물려받되 같은 바이트인지를 sha256 으로 다시 확인했다.
- **신규 검토(그림 4·5)** — 그 표에 행이 없던 두 장이다. 코디(pi-durable)가 2026-10-15 에 이미지를
  직접 열어 고객명 · 내부 endpoint · 개인정보가 보이지 않음을 확인했고, Opus(Claude Code)도 같은 날
  열어 캡션의 시점 경계를 정했다. 둘 다 개인 프로젝트(entwurf)의 개념도이고 회사 도해가 아니다.

## 다시 들인 결정

- 2026-10-15 GLG (코디 경유 전달, 원문): 「이미지를 여기 안담을 이유가 없을텐데? 그리고 수선도 해야된다.」
- 제거 당시의 판단 — 고용 기밀 여부는 스캐너가 답할 수 없으니 보류하지 않고 뺀다 — 은 기록으로
  남는다. 다시 들인 것은 그 판단을 뒤집은 것이 아니라 **건별 판정이 생겼기 때문**이다. 판정이 없는
  도해는 여전히 들이지 않는다.

## 검사

`../run.sh verify` 가 산출물마다 소스가 기대하는 그림 수(`:noexport:` 서브트리 밖의 이미지 링크 수)와
PDF 캡션 · ODT 임베드 · Markdown 이미지 수를 대조한다. 참조한 파일이 없으면 빌드 전에 멈춘다.
