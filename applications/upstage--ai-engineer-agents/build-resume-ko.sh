#!/usr/bin/env bash
# Upstage에 실제 제출한 영문 AI Engineer 이력서의 국문 읽기본을 생성한다.
#
#   ./build-resume-ko.sh
#
# 정본: resume-ko.md
# 산출: build/KimJunghan_Resume_AI_Engineer_KO.pdf
#
# 이 PDF는 2026-08-01 제출 스냅샷이 아니다. 실제로 올린 영문 PDF와 submit/의
# MANIFEST.sha256는 건드리지 않고, 이후 참고·공유를 위한 별도 build/ 산출물만 만든다.
# 조판 환경은 resume/ flake가 고정한 XeLaTeX·Pretendard·D2Coding을 사용한다.
set -euo pipefail
cd "$(dirname "$0")"

if [ -z "${APPLY_TEX_SHELL:-}" ]; then
	command -v nix >/dev/null || { echo 'nix 가 없다 — 조판 환경을 세울 수 없다' >&2; exit 1; }
	exec nix develop 'path:../../resume' --command env APPLY_TEX_SHELL=1 ./build-resume-ko.sh "$@"
fi

for tool in pandoc pdfinfo pdftotext; do
	command -v "$tool" >/dev/null || { echo "$tool 이 없다" >&2; exit 1; }
done
kpsewhich xetexko.sty >/dev/null || { echo 'xetexko 가 없다 (한글 조판 규칙)' >&2; exit 1; }

families=$(fc-list : family)
case $(printf '%s' "$families" | tr ',' '\n') in
*Pretendard*) ;;
*) echo 'Pretendard 활자가 없다 — 대체 활자로 조판되면 제출본이 달라진다' >&2; exit 1 ;;
esac

mkdir -p build
out='build/KimJunghan_Resume_AI_Engineer_KO.pdf'
pandoc resume-ko.md \
	-o "$out" \
	--pdf-engine=xelatex \
	-H pipeline/resume-header.tex \
	-V mainfont=Pretendard \
	-V monofont=D2Coding \
	-V geometry:a4paper \
	-V geometry:left=1.45cm,right=1.45cm,top=1.25cm,bottom=1.35cm \
	-V colorlinks=true \
	-V linkcolor=accent -V urlcolor=accent -V toccolor=accent

pages=$(pdfinfo "$out" | awk '/^Pages:/ {print $2}')
size=$(pdfinfo "$out" | awk '/^Page size:/ {print $3, $5}')
text=$(pdftotext -layout "$out" -)

[ "$pages" -le 4 ] || { echo "이력서가 ${pages}쪽이다 — 4쪽을 넘었다" >&2; exit 1; }
awk -v s="$size" 'BEGIN { split(s, d, " "); exit !(d[1] > 593 && d[1] < 598 && d[2] > 840 && d[2] < 844) }' \
	|| { echo "A4 판면이 아니다: $size" >&2; exit 1; }
for expected in '김정한' '요약' '핵심 역량' 'GoQual Inc.' '제3자 검증' '학력 및 수상' '[email removed]'; do
	case "$text" in
	*"$expected"*) ;;
	*) echo "PDF 텍스트에 필수 항목이 없다: $expected" >&2; exit 1 ;;
	esac
done

printf 'Korean resume: %s pages, A4 (%s), %s\n' "$pages" "$size" "$out"
