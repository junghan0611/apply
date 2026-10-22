# 이 세트를 어떻게 다시 만드나 — telechips--embedded-sw-engineer (2026-10-22 제출)

두 PDF 와 `form-0N.txt` 는 케이스 `build.sh` 가 Org 정본에서 만든다. 재현점은 이 파일이 담긴 커밋이다.

```bash
cd applications/telechips--embedded-sw-engineer
./build.sh review <새 빈 폴더>                 # 검토본 — 생년월일 칸 비움
./build.sh final  <새 빈 폴더> < (생년월일)    # 제출본 — 생년월일은 표준입력으로만
./test_build.sh                               # 실패 주입 회귀검사
```

제출 빌드에 들어간 입력 9개의 지문(빌드가 남긴 `SOURCES.sha256` 그대로). 경로는 `resume/`가
저장소 루트 기준, 나머지는 이 케이스 폴더 기준이다.

```text
007ae45275ca171e6f2413db05b350875c526ee31f92513c0ec0be79ad73da56  application-telechips.org
e1a49a875290e779ebb0e1f5f9e9e8525af3b4afe82f118725d881a500727f5f  answers.md
06b838784902120e7c9bba7e49bea745f0559283124661d08c312f58c3b00085  build.sh
8e9e9635ef7234eef7d629b6eae7218f2fa33efd20d5ddf9552b5f16ee2d8e08  resume/body.org
ab1e4d38783741b8d02b6752e707ffd0ba37a51607f256b69eac53839b0049b6  resume/resume.org
a401cfbd72e6931ec5eb2d7e7939a57d69bf06c8cfaa5528bfcd09083168b047  resume/portfolio-ko.org
ed5a8f5edee2229f80fc26e1de28f214457a8e9914710bc6533e49ff2ff90b29  resume/pipeline/latex-export.el
3b9ee75b96171b9688adc3f58a59b3df0c0bdb040de6f8c74c581c852aa54ca8  resume/pipeline/preamble.org
bb1090d48393f6d3b78bb1f05e762eca74b7e6251f8f373dcc92a4afa8a484ad  resume/flake.lock
```

- PDF 는 바이트 재현이 아니다. 빌드마다 끝 트레일러의 `/ID` 가 달라진다. 같은 입력이면 `pdftotext`
  결과가 같다(10/22 검토본과 10/21 검토본 대조로 측정).
- 경력요약·담당업무 txt 는 같은 입력에서 바이트까지 같다.
- 사진은 빌드 산출물이 아니다. 원본을 그대로 올렸다.
