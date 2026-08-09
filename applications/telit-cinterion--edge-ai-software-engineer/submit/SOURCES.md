# 이 세트를 어떻게 다시 만드나 — telit-cinterion--edge-ai-software-engineer

**새 깊이 PDF(`KimJunghan_AX_*`)는 git 에 없다** (`.gitignore`). 산출물이고 정본은 org 다.
이력서 컷과 제출 완료 건의 옛 스냅샷은 **이미 tracked 라 `git pull` 로 온다** —
「PDF 가 아예 없다」는 절대명제가 아니다.

`MANIFEST.sha256` 은 **그때 낸 파일의 identity commitment** 다. 파일이 있으면
**바이트 동일 여부를 판정**하고, 없으면 증언만 보존한다. 원본을 버린 뒤 비결정적
빌드가 지문과 어긋나면 *무엇이* 달라졌는지는 말해 주지 않는다 — 재현 경로는 아래다.

- ⭐ **재현점은 이 파일이 담긴 커밋이다.** 그 커밋에 org 정본이 함께 들어 있다 —
  `git log --oneline -- <이 파일>` 로 찾고 해당 산출물의 dossier 정본 org를 `git show`로 꺼낸다.
  (커밋 SHA 를 여기 박지 않는다. 박으면 커밋할 때마다 이 파일이 갱신되는 순환이 생긴다.)

```bash
(cd resume   && ./run.sh all)        # 이력서 여섯 컷
applications/stage.py                 # 세트를 다시 깐다 (누출·낡음을 스스로 검사한다)
applications/check.py --deep          # 전체 게이트 — 조준 누출 + 지문 대조
```

생성: `applications/stage.py` · 손으로 고치지 않는다.
