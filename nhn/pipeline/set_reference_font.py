#!/usr/bin/env python3
"""Set the ODT style master's text font and base size reproducibly.

The reference ODT is a ZIP. This script updates font attributes in styles.xml and
content.xml while preserving every other package member. OpenSymbol is retained
for list bullets; all prose/code font-name attributes use the requested family.
"""

from __future__ import annotations

import argparse
import os
import re
import tempfile
import zipfile
from pathlib import Path

FONT_ATTR = re.compile(
    r'(?P<prefix>style:font-name(?:-asian|-complex)?=")(?P<value>[^"]+)(?P<suffix>")'
)
FONT_FACE_END = "</office:font-face-decls>"


def rewrite_xml(text: str, font: str, body_size: str, *, resize: bool) -> tuple[str, int, int]:
    font_changes = 0

    def replace_font(match: re.Match[str]) -> str:
        nonlocal font_changes
        old = match.group("value")
        if old == "OpenSymbol" or old == font:
            return match.group(0)
        font_changes += 1
        return f'{match.group("prefix")}{font}{match.group("suffix")}'

    text = FONT_ATTR.sub(replace_font, text)

    declaration = (
        f'<style:font-face style:name="{font}" svg:font-family="\'{font}\'" '
        'style:font-family-generic="modern" style:font-pitch="fixed" />'
    )
    if f'style:name="{font}"' not in text and FONT_FACE_END in text:
        text = text.replace(FONT_FACE_END, f" {declaration}{FONT_FACE_END}", 1)
        font_changes += 1

    size_changes = 0
    if resize:
        for attribute in ("fo:font-size", "style:font-size-asian", "style:font-size-complex"):
            pattern = f'{attribute}="12pt"'
            replacement = f'{attribute}="{body_size}pt"'
            count = text.count(pattern)
            text = text.replace(pattern, replacement)
            size_changes += count

    return text, font_changes, size_changes


def transform_odt(path: Path, font: str, body_size: str) -> tuple[int, int]:
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
                        font,
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
            if f'style:name="{font}"' not in styles or f'style:font-name="{font}"' not in styles:
                raise RuntimeError("requested font was not written to styles.xml")

        os.replace(temp, path)
    finally:
        temp.unlink(missing_ok=True)

    return total_font, total_size


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("odt", type=Path)
    parser.add_argument("--font", default="GLG Nerd Font Mono")
    parser.add_argument("--body-size", default="10.5", help="Base size in pt; existing 12pt body styles are changed")
    args = parser.parse_args()

    path = args.odt.expanduser().resolve()
    if not path.is_file():
        parser.error(f"ODT not found: {path}")

    font_changes, size_changes = transform_odt(path, args.font, args.body_size)
    print(f"updated: {path}")
    print(f"font: {args.font} ({font_changes} attributes/declarations changed)")
    print(f"body size: {args.body_size}pt ({size_changes} attributes changed)")


if __name__ == "__main__":
    main()
