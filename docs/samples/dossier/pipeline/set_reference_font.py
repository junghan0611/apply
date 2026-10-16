#!/usr/bin/env python3
"""ODT 스타일 마스터의 활자를 역할별로 지정한다.

왜 역할별인가
-------------
이전 판은 ``--font`` 하나를 받아 styles.xml/content.xml 의 모든 ``style:font-name*``
속성에 같은 값을 박고, 그 폰트를 이렇게 선언했다::

    style:font-family-generic="modern" style:font-pitch="fixed"

ODF 에서 ``modern``/``fixed`` 는 "이것은 등폭 코드 활자다" 라는 선언이다. 그래서 본문
문단도, 제목도, 표도 전부 등폭으로 조판됐다. 양쪽정렬과 겹치면서 어절 사이가 벌어지고
줄 끝에서 라틴 낱말이 하이픈 없이 잘렸다 — 워드프로세서가 그렇게 조판하라는 지시를
문서 자체가 들고 있었던 것이라, 폰트를 바꿔도 지시가 남아 있으면 증상은 그대로다.

문서에는 본문과 코드라는 두 역할이 있고, 활자도 둘이어야 한다. 어느 쪽인지는 폰트
이름이 아니라 **스타일 이름** 이 안다(OrgSrcBlock, Preformatted Text, …). 그래서 이
스크립트는 각 ``style:font-name`` 이 어느 ``<style:style>`` 안에 있는지 추적해서 역할을
정한다.

사용법::

    python set_reference_font.py templates/reference.odt \
        --prose-font Pretendard --mono-font D2Coding --body-size 10.5
"""

from __future__ import annotations

import argparse
import os
import re
import tempfile
import zipfile
from pathlib import Path

# 스타일 정의가 열리는 지점. 뒤따르는 font-name 속성은 다음 정의가 열릴 때까지 이 스타일의 것이다.
STYLE_OPEN = re.compile(
    r'<style:(?:default-)?style\b[^>]*?style:name="(?P<name>[^"]*)"[^>]*>'
    r'|<style:default-style\b(?P<default>[^>]*)>'
)
FONT_ATTR = re.compile(
    r'(?P<prefix>style:font-name(?:-asian|-complex)?=")(?P<value>[^"]+)(?P<suffix>")'
)
FONT_FACE_END = "</office:font-face-decls>"

# 등폭이어야 하는 스타일. Org 가 코드·예제·고정폭 블록에 붙이는 이름들이다. 부분 일치로
# 보는 이유는 ox-odt 가 같은 뿌리에 접미사를 붙여 파생 스타일을 만들기 때문이다
# (OrgSrcBlock → OrgSrcBlockLastLine 등).
MONO_STYLE_MARKERS = (
    "SrcBlock",
    "Preformatted",
    "FixedWidth",
    "Source_20_Text",
    "OrgCode",
    "Teletype",
    "Example",
)

# 본문 활자로 선언할 값. Pretendard 는 산세리프라 swiss 가 맞고, variable 은 비례폭이라는 뜻이다.
PROSE_DECL = 'style:font-family-generic="swiss" style:font-pitch="variable"'
MONO_DECL = 'style:font-family-generic="modern" style:font-pitch="fixed"'


def style_name_at(text: str, position: int, opens: list[tuple[int, str]]) -> str:
    """POSITION 바로 앞에서 열린 스타일의 이름."""
    name = ""
    for start, style_name in opens:
        if start > position:
            break
        name = style_name
    return name


def is_mono_style(style_name: str) -> bool:
    return any(marker in style_name for marker in MONO_STYLE_MARKERS)


def rewrite_xml(
    text: str, prose_font: str, mono_font: str, body_size: str, *, resize: bool
) -> tuple[str, int, int]:
    opens = [(m.start(), m.group("name") or "") for m in STYLE_OPEN.finditer(text)]

    font_changes = 0

    def replace_font(match: re.Match[str]) -> str:
        nonlocal font_changes
        old = match.group("value")
        # OpenSymbol 은 글머리표 글리프를 담당한다. 본문 활자로 바꾸면 목록 불릿이 사라진다.
        if old == "OpenSymbol":
            return match.group(0)
        style_name = style_name_at(text, match.start(), opens)
        wanted = mono_font if is_mono_style(style_name) else prose_font
        if old == wanted:
            return match.group(0)
        font_changes += 1
        return f'{match.group("prefix")}{wanted}{match.group("suffix")}'

    text = FONT_ATTR.sub(replace_font, text)

    # 두 활자 모두 제 성격대로 선언한다. 선언이 없으면 워드프로세서는 이름만 보고
    # 짐작하고, 이름이 시스템에 없으면 짐작한 성격의 대체 활자로 조용히 떨어진다.
    declarations = []
    for font, decl in ((prose_font, PROSE_DECL), (mono_font, MONO_DECL)):
        if f'style:name="{font}"' not in text:
            declarations.append(
                f'<style:font-face style:name="{font}" '
                f"svg:font-family=\"'{font}'\" {decl} />"
            )
    if declarations and FONT_FACE_END in text:
        text = text.replace(FONT_FACE_END, " " + "".join(declarations) + FONT_FACE_END, 1)
        font_changes += len(declarations)

    size_changes = 0
    if resize:
        for attribute in ("fo:font-size", "style:font-size-asian", "style:font-size-complex"):
            pattern = f'{attribute}="12pt"'
            replacement = f'{attribute}="{body_size}pt"'
            count = text.count(pattern)
            text = text.replace(pattern, replacement)
            size_changes += count

    return text, font_changes, size_changes


def transform_odt(path: Path, prose_font: str, mono_font: str, body_size: str) -> tuple[int, int]:
    total_font = 0
    total_size = 0
    fd, temp_name = tempfile.mkstemp(prefix=path.stem + ".", suffix=".odt", dir=path.parent)
    os.close(fd)
    temp = Path(temp_name)

    try:
        with zipfile.ZipFile(path, "r") as source, zipfile.ZipFile(temp, "w") as target:
            for info in source.infolist():
                data = source.read(info.filename)
                if info.filename in {"styles.xml", "content.xml"}:
                    text = data.decode("utf-8")
                    text, font_changes, size_changes = rewrite_xml(
                        text,
                        prose_font,
                        mono_font,
                        body_size,
                        resize=info.filename == "styles.xml",
                    )
                    total_font += font_changes
                    total_size += size_changes
                    data = text.encode("utf-8")

                compression = zipfile.ZIP_STORED if info.filename == "mimetype" else zipfile.ZIP_DEFLATED
                cloned = zipfile.ZipInfo(info.filename, date_time=info.date_time)
                cloned.comment = info.comment
                cloned.extra = info.extra
                cloned.internal_attr = info.internal_attr
                cloned.external_attr = info.external_attr
                cloned.create_system = info.create_system
                target.writestr(cloned, data, compress_type=compression)

        with zipfile.ZipFile(temp, "r") as check:
            if check.testzip() is not None:
                raise RuntimeError("rewritten ODT failed ZIP integrity check")
            styles = check.read("styles.xml").decode("utf-8")
            for font in (prose_font, mono_font):
                if f'style:name="{font}"' not in styles:
                    raise RuntimeError(f"font was not declared in styles.xml: {font}")
            if f'style:font-name="{prose_font}"' not in styles:
                raise RuntimeError("prose font was not applied to any style")
            # 본문이 등폭으로 선언되는 회귀를 여기서 잡는다. 이 문서가 한 번 겪은 실패다.
            # 검사 범위는 반드시 그 선언 태그 하나로 끊는다 — 고정 길이로 잘라 읽으면
            # 바로 뒤에 붙는 등폭 활자 선언의 fixed 를 같이 읽고 오탐한다.
            prose_decl_index = styles.find(f'style:name="{prose_font}"')
            decl_end = styles.find(">", prose_decl_index)
            decl_tag = styles[prose_decl_index:decl_end]
            if 'style:font-pitch="fixed"' in decl_tag:
                raise RuntimeError("prose font is declared fixed-pitch — body text would set as code")

        os.replace(temp, path)
    finally:
        temp.unlink(missing_ok=True)

    return total_font, total_size


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("odt", type=Path)
    parser.add_argument(
        "--prose-font",
        default="Pretendard",
        help="본문·제목·표에 쓸 비례폭 활자. flake 가 고정하는 것과 같아야 한다",
    )
    parser.add_argument(
        "--mono-font",
        default="D2Coding",
        help="코드·예제 블록에 쓸 등폭 활자",
    )
    parser.add_argument(
        "--body-size",
        default="10.5",
        help="기준 크기(pt). 기존 12pt 본문 스타일이 이 값으로 바뀐다",
    )
    args = parser.parse_args()

    path = args.odt.expanduser().resolve()
    if not path.is_file():
        parser.error(f"ODT not found: {path}")

    font_changes, size_changes = transform_odt(
        path, args.prose_font, args.mono_font, args.body_size
    )
    print(f"updated: {path}")
    print(f"prose: {args.prose_font} / mono: {args.mono_font} ({font_changes} changes)")
    print(f"body size: {args.body_size}pt ({size_changes} attributes changed)")


if __name__ == "__main__":
    main()
