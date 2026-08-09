#!/usr/bin/env bash
# build.sh — 텔레칩스 폼의 **포트폴리오(필수) 칸**에 낼 임베디드 축 깊이 문서를 만든다.
#
#   ./build.sh
#
# 산출: submit/KimJunghan_Embedded_Experience_Detail.pdf   ← 포트폴리오 칸
#       (`../stage.py` 가 옮기지 않는다 — 이유는 §OUT 주석)
#
# 🔁 **이 문서는 회사 중립판이라 임베디드 축 다른 건에도 그대로 쓴다.**
#    Bear Robotics 의 `기타 첨부 서류`(선택), Telit Cinterion 의 `Upload Additional Files`
#    가 같은 자리다. 아래 §회사 중립 게이트가 그 재사용을 지킨다.
#
# ## 왜 이 파일이 있는가
#
# 이 폼은 **포트폴리오를 필수로 받는다**(`submission.md` §폼 실측 11번). dossier 의
# `KimJunghan_AX_Portfolio.pdf` 는 AX 전환·에이전트 플랫폼 축으로 쓴 글이라 이 자리의
# 답이 아니다 — 「첨부를 늘리는 것이 성의가 아니라, 그 자리에 맞는 것을 내는 것이 성의다」
# (`../AGENTS.md`). 그래서 임베디드 축 깊이 문서를 따로 뜬다.
#
# 선례는 `../deepx--linux-bsp-engineer/build.sh` 다. 다른 점이 둘 있다.
#
#   1. DEEPX 는 폼이 「하나의 파일로 통합」을 요구해 이력서와 붙였다. 이 폼은 **이력서 칸과
#      포트폴리오 칸이 따로**라 붙이지 않는다. 붙이면 이력서가 두 번 나간다.
#   2. `experience-detail.md` 본문에서 **자가 측정 수치를 걷어냈다** (2026-07-29 GLG 원칙4).
#      DEEPX 판에는 부팅 45.4→5.8초 · 메모리 816→246MiB · 코드 공유 96% 가 남아 있는데
#      그것은 그때 나간 문서라 고치지 않는다. **새로 나가는 문서는 원칙4 를 지킨다.**
#
# 조판은 `../../resume/` 의 flake devshell 을 탄다. 호스트 texlive 에는 kotex-utf 가 없어
# xetexko 가 `kolabels-utf.sty` 를 찾다 멈추고, 그 devshell 이 FONTCONFIG_FILE 로 Pretendard
# 를 고정한다 — 활자가 없으면 XeTeX 는 조용히 대체 활자로 짜고 페이지는 멀쩡히 나온다.

set -euo pipefail
cd "$(dirname "$0")"

if [ -z "${APPLY_TEX_SHELL:-}" ]; then
	command -v nix >/dev/null || { echo 'nix 가 없다 — 조판 환경을 세울 수 없다' >&2; exit 1; }
	exec nix develop 'path:../../resume' --command env APPLY_TEX_SHELL=1 ./build.sh "$@"
fi

# `../stage.py` 는 「추가 첨부」 행에서 **`resume/build/` · `dossier/build/` 경로만** 읽는다.
# 건 안에서 만든 산출물은 그 정규식에 걸리지 않으므로, DEEPX 선례대로 **여기서 직접
# `submit/` 에 놓는다.** stage.py 의 청소는 정확한 이름 allowlist(`MANAGED`)로만 돌아서
# 이 파일을 지우지 않고, 「submit/ 에 이미 있던 산출물도 세트의 일부」 규칙으로 README·
# MANIFEST 에 함께 실린다.
OUT=submit/KimJunghan_Embedded_Experience_Detail.pdf

kpsewhich xetexko.sty >/dev/null || { echo 'xetexko 가 없다' >&2; exit 1; }
kpsewhich kolabels-utf.sty >/dev/null || { echo 'kotex-utf 가 없다' >&2; exit 1; }

# grep -q 는 첫 일치에서 끝나고, pipefail 이 그 SIGPIPE 를 fc-list 의 실패로 잡는다.
families=$(fc-list : family)
case $(printf '%s' "$families" | tr ',' '\n') in
*Pretendard*) ;;
*) echo 'Pretendard 활자가 없다 — 제출본이 달라진다' >&2; exit 1 ;;
esac

mkdir -p build submit

# -f markdown-smart 로 스마트 따옴표를 끈다. 켜 두면 pandoc 이 ' 를 U+2019 로 바꾸는데,
# xetexko 가 그것을 CJK 문장부호로 보고 뒤에 여백을 넣어 «runtime' s» 처럼 벌어진다.
pandoc experience-detail.md \
	-f markdown-smart \
	-o "$OUT" \
	--pdf-engine=xelatex \
	-H pipeline/header.tex \
	-V mainfont=Pretendard \
	-V fontsize=10pt \
	-V geometry:a4paper \
	-V geometry:left=2.0cm,right=2.0cm,top=1.8cm,bottom=1.8cm \
	-V colorlinks=true \
	-V linkcolor=accent -V urlcolor=accent -V toccolor=accent

# ── 검수 ─────────────────────────────────────────────────────────────────────
pages=$(pdfinfo "$OUT" | awk '/^Pages:/ {print $2}')
printf '포트폴리오(임베디드 축) %s쪽\n' "$pages"
[ "$pages" -le 8 ] || echo '⚠ 8쪽을 넘었다 — 서류 검토자가 훑는 문서다' >&2

text=$(pdftotext "$OUT" -)

# 활자가 임베딩되지 않으면 한글·본문이 빈칸으로 나간다. 눈으로는 안 보이는 사고다.
for needle in 'RISC-V' 'Boundaries' 'Junghan Kim' 'board HAL'; do
	case $text in
	*"$needle"*) ;;
	*) echo "⚠ 산출물에서 «$needle» 를 찾지 못했다 — 조판이 잘못됐다" >&2; exit 1 ;;
	esac
done

# 🔴 원칙4 게이트 — 07-29 에 걷어낸 자가 측정 수치가 되돌아오지 않았는지 본다.
#    DEEPX 판을 복사해 고칠 때 실제로 되돌아올 수 있는 자리다.
for banned in '45.4' '5.8 s' '816' '246 MiB' '96%' '163' '2,945'; do
	case $text in
	*"$banned"*) echo "⚠ 자가 측정 수치 «$banned» 가 남아 있다 — AGENTS.md §숫자" >&2; exit 1 ;;
	esac
done

# 🔴 회사 중립 게이트 — 이 문서는 **중립판이 정본**이라 다른 건에도 그대로 쓸 수 있어야 한다.
#    조준 문장이 들어가면 그 순간 재사용이 막힌다 (`../AGENTS.md` §깊이 문서는 회사 중립판이 정본).
for company in 'Telechips' '텔레칩스' 'DEEPX' 'Bear Robotics' 'Sonatus'; do
	case $text in
	*"$company"*) echo "⚠ 회사 이름 «$company» 가 본문에 있다 — 중립판이 아니다" >&2; exit 1 ;;
	esac
done

# 이력서에 전화번호가 새어 들어가지 않았는지.
case $text in
*01[016789]-*) echo '⚠ 산출물에 전화번호로 보이는 문자열이 있다 — 확인하라' >&2 ;;
esac

ls -la submit/
