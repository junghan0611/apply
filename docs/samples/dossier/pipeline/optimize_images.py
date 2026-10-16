#!/usr/bin/env python3
"""생성 원본 인포그래픽을 문서에 실을 크기로 줄인다.

왜 필요한가
-----------
이미지 생성기는 2752x1536 트루컬러 PNG 를 내놓는다. 장당 3MB 대다. XeTeX 도 ox-odt 도
PNG 를 그대로 품기 때문에, 여섯 장이 PDF·ODT·DOC 여섯 산출물에 각각 박히면서 8쪽짜리
포트폴리오 PDF 가 16MB, 증거 패키지 ZIP 이 82MB 가 됐다. 채용 포털 업로드에서 막히는
크기이고, 무엇보다 그 용량이 문서에 아무것도 더해주지 않는다.

본문 판면은 A4 에서 좌우 3cm 를 빼고 약 425pt = 5.9in 다. 원본은 그 폭에 466 DPI 로
들어가는 셈인데, 화면과 인쇄 어느 쪽도 그만큼을 쓰지 않는다.

줄이는 방법을 고른 이유
-----------------------
이 그림들은 사진이 아니라 평면 인포그래픽이다. 고유색이 3만 개 넘게 잡히지만 대부분
글자 가장자리의 안티에일리어싱이라, 256색 팔레트로 옮겨도 눈에 띄는 손상이 없다.
JPEG 은 비슷한 용량에서 글자 가장자리에 링잉을 남기므로 쓰지 않는다 — 이 그림들의
내용은 대부분 글자다.

원본은 지우지 않는다. 생성은 비결정적이라 같은 프롬프트로 같은 그림이 다시 나오지
않는다. 그래서 master/ 를 정본으로 두고, 문서가 참조하는 자리에는 줄인 판을 놓는다.

사용법::

    python optimize_images.py images/master images
"""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
from pathlib import Path

# 본문 판면 425pt(5.9in)에 약 270 DPI. 그 이상은 파일만 키우고 보이지 않는다.
DEFAULT_WIDTH = 1600
# 평면 인포그래픽의 실제 색 수는 팔레트 몇 십 개 수준이다. 256 은 넉넉한 상한.
DEFAULT_COLORS = 256

SUFFIXES = {".png", ".jpg", ".jpeg", ".webp"}


def find_magick() -> str:
    for candidate in ("magick", "convert"):
        if shutil.which(candidate):
            return candidate
    sys.exit("ImageMagick(magick 또는 convert)이 PATH 에 없습니다.")


def optimize(magick: str, source: Path, target: Path, width: int, colors: int) -> None:
    subprocess.run(
        [
            magick,
            str(source),
            # 원본보다 키우지 않는다. '>' 는 지정 폭보다 넓을 때만 줄이라는 뜻이다.
            "-resize", f"{width}x>",
            "-colors", str(colors),
            # 생성기가 남긴 EXIF·색 프로파일을 턴다. 문서에는 쓸모가 없고 용량만 는다.
            "-strip",
            f"PNG8:{target}",
        ],
        check=True,
    )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path, help="생성 원본이 있는 디렉터리")
    parser.add_argument("target", type=Path, help="문서가 참조하는 디렉터리")
    parser.add_argument("--width", type=int, default=DEFAULT_WIDTH)
    parser.add_argument("--colors", type=int, default=DEFAULT_COLORS)
    args = parser.parse_args()

    if not args.source.is_dir():
        sys.exit(f"원본 디렉터리 없음: {args.source}")
    args.target.mkdir(parents=True, exist_ok=True)

    magick = find_magick()
    sources = sorted(p for p in args.source.iterdir() if p.suffix.lower() in SUFFIXES)
    if not sources:
        sys.exit(f"줄일 이미지가 없습니다: {args.source}")

    before = after = 0
    for source in sources:
        target = args.target / (source.stem + ".png")
        optimize(magick, source, target, args.width, args.colors)
        b, a = source.stat().st_size, target.stat().st_size
        before += b
        after += a
        print(f"  {source.name:28s} {b/1e6:6.2f}MB → {a/1e6:5.2f}MB  ({b/a:.1f}x)")

    print(f"합계 {before/1e6:.1f}MB → {after/1e6:.1f}MB  ({before/after:.1f}x)")


if __name__ == "__main__":
    main()
