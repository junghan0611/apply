#!/usr/bin/env bash
# build.sh — 이 건의 국문 자기소개서를 PDF 로 낸다.
#
#   ./build.sh
#
# 산출: submit/KimJunghan_CoverLetter_KO.pdf
#
# 오토에버 판(`../hyundai-autoever--ai-agent-engineer/build.sh`)과 한 곳만 다르다 —
# **이력서 컷을 복사하지 않는다.** 이 건은 아직 `ready` 라 `applications/stage.py` 가
# `submit/` 을 관리하고, 이력서 컷은 그쪽이 깐다.
#
# 자기소개서 PDF 는 `submit/` 에 직접 낸다. stage.py 는 자기가 아는 이름(`MANAGED`)만
# 치우고 **소스를 모르는 파일은 건드리지 않으므로** 이 파일은 세트에 그대로 남아
# MANIFEST·README 에 함께 잡힌다. 건-로컬 `build/` 를 세트로 옮기는 경로는 stage.py 에
# 아직 없다(`cuts_of` 는 `resume|dossier/build/` 만 읽는다) — 그래서 오토에버가 검증한
# 이 방식을 따른다.
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

# 이 건의 공개 증거면. 연락처 줄에서 조용히 빠지면 제출본이 그 자리를 잃는다
# (2026-08-01 §ax 증거면 계약 — resume/ · dossier/ 의 verify 와 같은 검사다).
case $text in
*ax.junghanacs.com*) ;;
*)
	echo '⚠ ax.junghanacs.com 이 안 보인다 — 머리말 연락처 줄을 확인한다' >&2
	exit 1
	;;
esac

ls -la submit/
