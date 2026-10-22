# 제출 세트 — telechips--embedded-sw-engineer

**2026-10-22 GLG가 `iSXmKnRT` Embedded S/W Engineer 폼으로 최종 제출한 세트의 지문이다.**
실제 업로드 파일은 private 제출 보관면에 있고, 이 폴더에는 이름·칸·지문만 둔다.
`MANIFEST.sha256` 이 그날 낸 파일의 identity commitment 다.

| 파일 | 폼의 어느 칸 |
|---|---|
| `KimJunghan_Telechips_Application.pdf` | 이력서 (인적정보/경력기술/자기소개서 포함) — 국문 합본 3쪽, 생년월일은 `build.sh final` 표준입력 |
| `KimJunghan_Systems_Portfolio.pdf` | 포트폴리오(파일) — 국문 포트폴리오 2쪽. 빌드 산출 이름은 `KimJunghan_Systems_BSP_Portfolio.pdf`이고 바이트가 같다. 직무가 BSP가 아니라 GLG가 이름을 바꿔 이 이름으로 올렸다(10/22 GLG 확인) |
| `junghan_color.jpg` | 증명사진 — 10/18 GLG가 유지하기로 한 원본. 얼굴 이미지라 git 에 없다 |
| `form-01.txt` | 경력요약 — `answers.md` 문항 1 (775자, 10/22 GLG 승인) |
| `form-02.txt` · `form-03.txt` · `form-04.txt` | 경력사항 담당업무 — GoQual · 성균관대 연구실 · NEMO-UX (`answers.md` 문항 2–4) |

학력·경력 구조화 칸, 인적사항, 장애·보훈·병역·영어, 동의는 폼에서 사람이 입력했다. 값은 이 저장소에
두지 않는다. 그 원본은 private Org 면이 소유한다(`../../FAQ.md` §0).

## 이 폴더에 남은 2026-08-09 판

`MANIFEST-2026-08-09-ready.sha256` · `answers.txt` · `SOURCES.md`의 옛 판(git history)과 로컬의
`KimJunghan_Embedded_Experience_Detail.pdf` · `KimJunghan_ID_Photo.jpg`(gitignored)는 08-09
`stage.py` 가 깐 **제출되지 않은 ready 세트**다. 지문은 그대로 보존하며 10/22 제출과 다르다.
`sha256sum -c MANIFEST-2026-08-09-ready.sha256` 로 남아 있는 파일의 바이트를 지금도 대조할 수 있다.

이 건은 `submitted` 라 `applications/stage.py` 가 이 폴더를 다시 쓰지 않는다. 이 README 와
`SOURCES.md` 는 10/22 손으로 썼다 — 세트를 만든 것은 `stage.py` 가 아니라 케이스 `build.sh` 다.
