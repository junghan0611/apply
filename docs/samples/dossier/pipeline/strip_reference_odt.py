#!/usr/bin/env python3
"""스타일 마스터에서 원본 문서의 잔재를 걷어낸다.

왜 필요했나
-----------
templates/reference.odt 는 한글 제안서를 LibreOffice 로 저장해 만든 것이라, 스타일만이
아니라 그 제안서 자체를 통째로 들고 있었다 — 본문 10만 자, 이미지 48장, 9MB.

그런데 ox-odt 는 이 파일에서 styles.xml 하나만 꺼낸다(ox-odt.el 의 org-odt--build-styles-file:
확장자가 odt/ott 면 `org-odt--zip-extract` 로 "styles.xml" 만 가져간다). 나머지는 한 번도
쓰인 적이 없다. 즉 산출물에는 영향이 없으면서, `run.sh package` 가 만드는 증거 패키지에는
9MB 짜리 남의 문서가 실려 나가고 있었다. 용량 문제로 보였지만 실제로는 유출 문제였다.

meta.xml 도 지운다. 여기에는 원본 제안서의 제목(dc:title)이 남아 있어서, 파일을 열면
문서 속성에 그대로 보인다. styles.xml 은 텍스트가 쪽번호 필드뿐이라 그대로 둔다.

남기는 것: mimetype, META-INF/manifest.xml, styles.xml, 그리고 빈 content.xml/meta.xml.
결과는 LibreOffice 로 열어 스타일을 손볼 수 있는 빈 서식 문서다 — 스타일 마스터가
원래 있어야 할 모습이고, 이 파이프라인을 이어받는 사람이 조판을 고칠 자리이기도 하다.

사용법::

    python strip_reference_odt.py templates/reference.odt
"""

from __future__ import annotations

import argparse
import os
import re
import sys
import tempfile
import zipfile
from pathlib import Path

KEEP = {"mimetype", "styles.xml"}

EMPTY_CONTENT = """<?xml version="1.0" encoding="UTF-8"?>
<office:document-content \
xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" \
xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" \
xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" \
xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" \
xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" \
xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0" \
xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0" \
office:version="1.2">
 <office:scripts/>
 <office:font-face-decls></office:font-face-decls>
 <office:automatic-styles/>
 <office:body><office:text><text:p/></office:text></office:body>
</office:document-content>
"""

EMPTY_META = """<?xml version="1.0" encoding="UTF-8"?>
<office:document-meta \
xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" \
xmlns:dc="http://purl.org/dc/elements/1.1/" \
xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" \
office:version="1.2">
 <office:meta>
  <dc:title>Org ODT style master</dc:title>
  <meta:generator>dossier/pipeline/strip_reference_odt.py</meta:generator>
 </office:meta>
</office:document-meta>
"""

MANIFEST = """<?xml version="1.0" encoding="UTF-8"?>
<manifest:manifest \
xmlns:manifest="urn:oasis:names:tc:opendocument:xmlns:manifest:1.0" \
manifest:version="1.2">
 <manifest:file-entry manifest:media-type="application/vnd.oasis.opendocument.text" \
manifest:full-path="/" manifest:version="1.2"/>
 <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="content.xml"/>
 <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="styles.xml"/>
 <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="meta.xml"/>
</manifest:manifest>
"""


def prose_of(xml: str) -> str:
    return re.sub(r"\s+", " ", re.sub(r"<[^>]+>", " ", xml)).strip()


def strip(path: Path) -> tuple[int, int]:
    before = path.stat().st_size

    with zipfile.ZipFile(path, "r") as source:
        names = set(source.namelist())
        if "styles.xml" not in names:
            sys.exit("styles.xml 이 없습니다 — 스타일 마스터가 아닙니다.")
        styles = source.read("styles.xml")
        mimetype = source.read("mimetype") if "mimetype" in names else None

    # styles.xml 에 남은 텍스트를 보고한다. 머리말·꼬리말에 원본 문서의 문구가 박혀 있으면
    # 여기서만 드러나고, 그건 사람이 지워야 한다 — 스크립트가 조판을 임의로 고칠 수는 없다.
    residue = prose_of(styles.decode("utf-8", errors="replace"))
    if len(residue) > 40:
        print(f"  주의: styles.xml 에 텍스트 {len(residue)}자가 남아 있습니다 "
              f"(머리말·꼬리말 확인 필요): {residue[:120]!r}")

    fd, temp_name = tempfile.mkstemp(prefix=path.stem + ".", suffix=".odt", dir=path.parent)
    os.close(fd)
    temp = Path(temp_name)
    try:
        with zipfile.ZipFile(temp, "w") as target:
            # mimetype 은 ODF 규격상 첫 항목이어야 하고 무압축이어야 한다. 순서가 어긋나면
            # 일부 워드프로세서가 파일 형식을 알아보지 못한다.
            target.writestr(
                zipfile.ZipInfo("mimetype"),
                mimetype or b"application/vnd.oasis.opendocument.text",
                compress_type=zipfile.ZIP_STORED,
            )
            target.writestr("META-INF/manifest.xml", MANIFEST, zipfile.ZIP_DEFLATED)
            target.writestr("styles.xml", styles, zipfile.ZIP_DEFLATED)
            target.writestr("content.xml", EMPTY_CONTENT, zipfile.ZIP_DEFLATED)
            target.writestr("meta.xml", EMPTY_META, zipfile.ZIP_DEFLATED)

        with zipfile.ZipFile(temp, "r") as check:
            if check.testzip() is not None:
                raise RuntimeError("정리된 ODT 가 ZIP 무결성 검사를 통과하지 못했습니다")
            kept = set(check.namelist())
            missing = KEEP - kept
            if missing:
                raise RuntimeError(f"남겨야 할 항목이 빠졌습니다: {missing}")
            leftover = prose_of(check.read("content.xml").decode("utf-8"))
            if leftover:
                raise RuntimeError("content.xml 에 본문이 남아 있습니다")

        os.replace(temp, path)
    finally:
        temp.unlink(missing_ok=True)

    return before, path.stat().st_size


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("odt", type=Path)
    args = parser.parse_args()

    path = args.odt.expanduser().resolve()
    if not path.is_file():
        parser.error(f"ODT not found: {path}")

    before, after = strip(path)
    print(f"정리: {path}")
    print(f"  {before/1e6:.2f}MB → {after/1e6:.3f}MB  ({before/after:.0f}x)")


if __name__ == "__main__":
    main()
