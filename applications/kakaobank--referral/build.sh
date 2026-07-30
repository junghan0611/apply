#!/usr/bin/env bash
# KakaoBank referral one-page PDF builder (Markdown → HTML → Chrome PDF).
set -euo pipefail

DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
SRC="$DIR/KimJunghan_KakaoBank_Referral_Profile.md"
OUT="$DIR/KimJunghan_KakaoBank_Referral_Profile.pdf"

command -v pandoc >/dev/null || { echo "pandoc 이 없다"; exit 1; }
CHROME=$(command -v google-chrome-stable || command -v chromium || true)
[ -n "$CHROME" ] || { echo "Chrome 이 없다"; exit 1; }
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
@page {{ size:A4; margin:12mm 13mm; }}
html,body,* {{ font-family:"PD",sans-serif; }}
html {{ font-size:9.2pt; }}
body {{ line-height:1.34; color:#111; }}
h1 {{ font-size:14pt; margin:0 0 .35em; letter-spacing:-.025em; }}
h2 {{ font-size:10.6pt; margin:.72em 0 .22em; }}
hr {{ border:0; border-top:1px solid #bbb; margin:.55em 0 .65em; }}
p {{ margin:.3em 0; }}
ul {{ margin:.24em 0 .34em 1.1em; padding:0; }}
li {{ margin:.13em 0; }}
strong {{ font-weight:700; }}
code {{ background:#f3f3f3; padding:0 2px; border-radius:2px; font-size:.92em; }}
''')
PY

pandoc "$SRC" -s --metadata title="" -c "$TMP/style.css" --embed-resources -o "$TMP/page.html"
RAW="$TMP/raw.pdf"
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf="$RAW" "file://$TMP/page.html" 2>/dev/null

# Chrome가 A4를 거의 맞추지만 594.96×841.92pt 같은 근사 MediaBox를 만들 수 있다.
# 카카오톡/모바일 뷰어에서 판형이 애매하게 보이지 않도록 Ghostscript로 정확한 A4 MediaBox로 정규화한다.
gs -q -dNOPAUSE -dBATCH \
	-sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dFIXEDMEDIA -dPDFFitPage -sPAPERSIZE=a4 \
	-sOutputFile="$OUT" "$RAW"

PAGES=$(gs -q -dNODISPLAY -dNOSAFER -c "($OUT) (r) file runpdfbegin pdfpagecount = quit")
BOX=$(gs -q -dNODISPLAY -dNOSAFER -c "($OUT) (r) file runpdfbegin 1 pdfgetpage /MediaBox get == quit")
echo "$OUT — ${PAGES}쪽 · MediaBox ${BOX}"
