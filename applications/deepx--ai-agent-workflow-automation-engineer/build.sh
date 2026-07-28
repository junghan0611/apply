#!/usr/bin/env bash
# build.sh — DEEPX 입사지원서(통합 PDF) 를 낸다.
#
#   ./build.sh
#
# 산출: submit/KimJunghan_DEEPX_Application.pdf
#         = [이력서 AI Engineer 컷]  +  [경력기술서 Experience Detail]
#
# 이 폼은 «하나의 파일만 업로드가 가능하오니 하나의 파일로 통합하여 제출해주세요» 라고
# 명시한다. 그래서 두 문서를 조판한 뒤 pdfunite 로 한 벌로 붙인다. 이력서는 여기서 만들지
# 않는다 — `../../resume/` 가 정본이고 여기서는 최신 산출물을 끌어다 붙이기만 한다.
#
# 조판은 `../../resume/` 의 flake devshell 을 탄다. 호스트 texlive 에는 kotex-utf 가 없어
# xetexko 가 `kolabels-utf.sty` 를 찾다 멈추고, 그 devshell 은 FONTCONFIG_FILE 로 Pretendard
# 를 고정한다 — 활자가 없으면 XeTeX 는 조용히 대체 활자로 짜고 페이지는 멀쩡히 나온다.

set -euo pipefail
cd "$(dirname "$0")"

if [ -z "${APPLY_TEX_SHELL:-}" ]; then
	command -v nix >/dev/null || { echo 'nix 가 없다 — 조판 환경을 세울 수 없다' >&2; exit 1; }
	exec nix develop 'path:../../resume' --command env APPLY_TEX_SHELL=1 ./build.sh "$@"
fi

RESUME_CUT=../../resume/build/KimJunghan_Resume_AI_Engineer.pdf
OUT=submit/KimJunghan_DEEPX_Application.pdf

kpsewhich xetexko.sty >/dev/null || { echo 'xetexko 가 없다' >&2; exit 1; }
kpsewhich kolabels-utf.sty >/dev/null || { echo 'kotex-utf 가 없다' >&2; exit 1; }

# grep -q 는 첫 일치에서 끝나고, pipefail 이 그 SIGPIPE 를 fc-list 의 실패로 잡는다.
families=$(fc-list : family)
case $(printf '%s' "$families" | tr ',' '\n') in
*Pretendard*) ;;
*) echo 'Pretendard 활자가 없다 — 제출본이 달라진다' >&2; exit 1 ;;
esac

[ -f "$RESUME_CUT" ] || { echo "이력서 컷이 없다: $RESUME_CUT" >&2; exit 1; }

mkdir -p submit build

# -f markdown-smart 로 스마트 따옴표를 끈다. 켜 두면 pandoc 이 ' 를 U+2019 로 바꾸는데,
# xetexko 가 그것을 CJK 문장부호로 보고 뒤에 여백을 넣어 «runtime' s» 처럼 벌어진다.
# 이 문서는 영문이라 ASCII 어포스트로피가 그대로 맞다. 줄표(—)는 원문에 직접 써 두었다.
pandoc experience-detail.md \
	-f markdown-smart \
	-o build/experience-detail.pdf \
	--pdf-engine=xelatex \
	-H pipeline/header.tex \
	-V mainfont=Pretendard \
	-V fontsize=10pt \
	-V geometry:a4paper \
	-V geometry:left=2.0cm,right=2.0cm,top=1.8cm,bottom=1.8cm \
	-V colorlinks=true \
	-V linkcolor=accent -V urlcolor=accent -V toccolor=accent

pdfunite "$RESUME_CUT" build/experience-detail.pdf "$OUT"

# ── 검수 ─────────────────────────────────────────────────────────────────────
# 통합본은 두 문서를 붙인 것이라 조용히 어긋날 자리가 둘이다: 이력서 쪽수가 바뀌어도
# 눈치채지 못하는 것과, 활자가 임베딩되지 않아 한글이 빈칸으로 나가는 것. 둘 다 여기서 막는다.
r_pages=$(pdfinfo "$RESUME_CUT" | awk '/^Pages:/ {print $2}')
d_pages=$(pdfinfo build/experience-detail.pdf | awk '/^Pages:/ {print $2}')
t_pages=$(pdfinfo "$OUT" | awk '/^Pages:/ {print $2}')

printf 'resume %s쪽 + 경력기술서 %s쪽 = 통합 %s쪽\n' "$r_pages" "$d_pages" "$t_pages"
[ "$t_pages" -eq "$((r_pages + d_pages))" ] || { echo '⚠ 쪽수 합이 맞지 않는다' >&2; exit 1; }
[ "$t_pages" -le 10 ] || echo '⚠ 통합본이 10쪽을 넘었다 — 서류 검토자가 훑는 문서다' >&2

text=$(pdftotext "$OUT" -)
for needle in 'entwurf' 'Boundaries' 'Junghan Kim'; do
	case $text in
	*"$needle"*) ;;
	*) echo "⚠ 통합본에서 «$needle» 를 찾지 못했다 — 붙이기가 잘못됐다" >&2; exit 1 ;;
	esac
done

# 이력서에 전화번호가 새어 들어가지 않았는지. resume/ 는 다른 레인이 손대는 중이라
# 여기서 한 번 더 본다.
case $text in
*01[016789]-*) echo '⚠ 통합본에 전화번호로 보이는 문자열이 있다 — 확인하라' >&2 ;;
esac

ls -la submit/
