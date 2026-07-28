#!/usr/bin/env bash
# build.sh — 이 건의 국문 자기소개서를 PDF 로 낸다.
#
#   ./build.sh
#
# 산출: submit/KimJunghan_CoverLetter_KO.pdf
#       submit/KimJunghan_Resume_AI_Engineer.pdf  (resume/ 발사대 산출물 복사)
#
# 이력서 PDF 는 여기서 만들지 않는다. `../../resume/` 가 만든 것을 submit/ 로 복사만 한다 —
# 사실이 두 곳에 있으면 어긋난다. 이력서를 고칠 일이 생기면 resume/ 에서 고치고
# `./run.sh target ai-engineer` 로 다시 낸 뒤 이 스크립트를 다시 돌린다.
#
# 조판은 `../../resume/` 의 flake devshell 을 그대로 탄다. 호스트 texlive 에는 kotex-utf 가
# 없어 xetexko 가 `kolabels-utf.sty` 를 찾다 멈춘다. 그리고 그 devshell 은 FONTCONFIG_FILE 로
# Pretendard 를 고정한다 — 활자가 없으면 XeTeX 는 조용히 대체 활자로 짜고 페이지는 멀쩡히
# 나오므로, 활자를 환경에 맡기면 "같은 소스에서 같은 문서가 나온다" 를 지킬 수 없다.

set -euo pipefail
cd "$(dirname "$0")"

# devshell 밖이면 자기 자신을 devshell 안에서 다시 부른다.
if [ -z "${APPLY_TEX_SHELL:-}" ]; then
	command -v nix >/dev/null || { echo 'nix 가 없다 — 조판 환경을 세울 수 없다' >&2; exit 1; }
	exec nix develop 'path:../../resume' --command env APPLY_TEX_SHELL=1 ./build.sh "$@"
fi

RESUME_CUT=../../resume/build/KimJunghan_Resume_AI_Engineer.pdf

kpsewhich xetexko.sty >/dev/null || { echo 'xetexko 가 없다 (한글 조판 규칙)' >&2; exit 1; }
kpsewhich kolabels-utf.sty >/dev/null || { echo 'kotex-utf 가 없다' >&2; exit 1; }

# grep -q 는 첫 일치에서 끝나고, pipefail 이 켜진 상태에서 그 SIGPIPE 가 fc-list 의 실패로
# 잡힌다. 활자가 있어도 없다고 나온다 — 목록을 먼저 받아 두고 검사한다.
families=$(fc-list : family)
case $(printf '%s' "$families" | tr ',' '\n') in
*Pretendard*) ;;
*)
	echo 'Pretendard 활자가 없다 — 대체 활자로 조판되면 제출본이 달라진다' >&2
	exit 1
	;;
esac

[ -f "$RESUME_CUT" ] || { echo "이력서 컷이 없다: $RESUME_CUT" >&2; exit 1; }

mkdir -p submit

pandoc cover-letter.md \
	-o submit/KimJunghan_CoverLetter_KO.pdf \
	--pdf-engine=xelatex \
	-H pipeline/header.tex \
	-V mainfont=Pretendard \
	-V fontsize=10pt \
	-V geometry:a4paper \
	-V geometry:left=2.1cm,right=2.1cm,top=1.9cm,bottom=1.9cm \
	-V colorlinks=true \
	-V linkcolor=accent -V urlcolor=accent -V toccolor=accent

cp -f "$RESUME_CUT" submit/

# 검수 — 쪽수와 한글 글리프 임베딩. 제출 직전에 사람이 눈으로 보는 것보다 먼저 걸러 둔다.
pages=$(pdfinfo submit/KimJunghan_CoverLetter_KO.pdf | awk '/^Pages:/ {print $2}')
printf 'cover letter: %s pages\n' "$pages"
[ "$pages" -le 3 ] || echo '⚠ 자기소개서가 3쪽을 넘었다 — 읽는 사람이 훑는 문서다' >&2

text=$(pdftotext submit/KimJunghan_CoverLetter_KO.pdf -)
case $text in
*기예가*) ;;
*)
	echo '⚠ 한글 텍스트 추출 실패 — 활자 임베딩을 확인한다' >&2
	exit 1
	;;
esac

ls -la submit/
