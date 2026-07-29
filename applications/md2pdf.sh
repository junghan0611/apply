#!/usr/bin/env bash
# md2pdf.sh — 마크다운 한 장을 제출용 PDF 로 굽는다.
#
# 왜 있나: 표지·커버레터·짧은 기술서처럼 「공고별 한 장짜리 문서」는 resume/dossier 의
# emacs → ox-latex → xelatex 파이프라인을 쓸 이유가 없다. 그 파이프라인은 정본 문서용이다.
#
# 경로: pandoc(md→HTML) → Chrome headless(HTML→PDF). TeX·typst·LibreOffice 불필요.
# 폰트는 Pretendard 를 data URI 로 HTML 안에 심는다 — Chrome 이 fontconfig 로 폰트를
# 고르게 두면 D2Coding(코딩용 고정폭)으로 떨어진다. 2026-07-29 실측.
#
# 서버(오라클)에는 Chrome 이 없다. 이 스크립트는 노트북에서 돈다.
#
#   ./md2pdf.sh <입력.md> <출력.pdf>
#
set -euo pipefail

SRC="${1:?사용법: md2pdf.sh <입력.md> <출력.pdf>}"
OUT="${2:?사용법: md2pdf.sh <입력.md> <출력.pdf>}"

command -v pandoc >/dev/null || { echo "pandoc 이 없다"; exit 1; }
CHROME=$(command -v google-chrome-stable || command -v chromium || true)
[ -n "$CHROME" ] || { echo "Chrome 이 없다 — 이 스크립트는 노트북 전용이다"; exit 1; }

REG=$(fc-match -f '%{file}' "Pretendard")
BOLD=$(fc-match -f '%{file}' "Pretendard:weight=bold")

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

python3 - "$REG" "$BOLD" "$TMP/style.css" <<'PY'
import base64, pathlib, sys
reg, bold, out = sys.argv[1:4]
b64 = lambda p: base64.b64encode(pathlib.Path(p).read_bytes()).decode()
pathlib.Path(out).write_text(f'''
@font-face {{ font-family:"PD"; font-weight:400; src:url(data:font/otf;base64,{b64(reg)}) format("opentype"); }}
@font-face {{ font-family:"PD"; font-weight:700; src:url(data:font/otf;base64,{b64(bold)}) format("opentype"); }}
@page {{ size:A4; margin:18mm 17mm; }}
html,body,* {{ font-family:"PD",sans-serif; }}
html {{ font-size:10.5pt; }}
body {{ line-height:1.55; color:#111; }}
h1 {{ font-size:15pt; margin:0 0 .5em; letter-spacing:-.02em; }}
h2 {{ font-size:12pt; margin:1.2em 0 .4em; }}
hr {{ border:0; border-top:1px solid #bbb; margin:.9em 0 1.1em; }}
p {{ margin:.55em 0; }}
table {{ border-collapse:collapse; width:100%; margin:.9em 0; font-size:9.6pt; }}
th,td {{ border:1px solid #ccc; padding:4px 7px; text-align:left; vertical-align:top; }}
th {{ background:#f2f2f2; }}
code {{ background:#f2f2f2; padding:0 3px; border-radius:2px; font-size:.92em; }}
blockquote {{ margin:.8em 0; padding-left:.9em; border-left:3px solid #ddd; color:#444; }}
''')
PY

pandoc "$SRC" -s --metadata title="" -c "$TMP/style.css" --embed-resources -o "$TMP/page.html"
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
	--print-to-pdf="$OUT" "file://$TMP/page.html" 2>/dev/null

PAGES=$(gs -q -dNODISPLAY -dNOSAFER \
	-c "($OUT) (r) file runpdfbegin pdfpagecount = quit")
echo "$OUT — ${PAGES}쪽"
