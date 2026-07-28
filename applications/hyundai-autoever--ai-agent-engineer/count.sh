#!/usr/bin/env bash
# count.sh — 사전질문 본문의 글자 수를 센다. 상한 1,000자.
#
#   ./count.sh
#
# 폼마다 세는 방식이 다르다(공백 포함 / 제외 / 줄바꿈 포함). 셋 다 찍어 두고, 가장 불리한
# 값이 상한 아래인지 본다. 바이트가 아니라 글자로 세야 한다 — 한글은 UTF-8 로 3바이트다.

set -euo pipefail
cd "$(dirname "$0")"

LIMIT=1000

# pre-question.md 의 첫 ```text 블록만 뽑는다. 본문이 두 곳에 있으면 어긋나므로
# 붙여넣는 원본은 그 블록 하나다.
body=$(awk '
	/^```text$/ { inblock = 1; next }
	/^```$/     { if (inblock) exit }
	inblock     { print }
' pre-question.md)

[ -n "$body" ] || { echo 'pre-question.md 에서 ```text 블록을 찾지 못했다' >&2; exit 1; }

# 앞뒤 빈 줄은 폼에 붙일 때 사라진다. 세기 전에 턴다.
body=$(printf '%s' "$body" | sed -e '/./,$!d' | tac | sed -e '/./,$!d' | tac)

count() { printf '%s' "$1" | wc -m | tr -d ' '; }

with_nl=$(count "$body")
no_nl=$(count "$(printf '%s' "$body" | tr -d '\n')")
no_ws=$(count "$(printf '%s' "$body" | tr -d '[:space:]')")

printf '줄바꿈 포함 · 공백 포함 : %s자\n' "$with_nl"
printf '줄바꿈 제외 · 공백 포함 : %s자\n' "$no_nl"
printf '공백 전부 제외          : %s자\n' "$no_ws"
printf '상한                    : %s자\n' "$LIMIT"

worst=$with_nl
if [ "$worst" -gt "$LIMIT" ]; then
	printf '\n⚠ 가장 불리한 셈법에서 %s자 초과 — 줄여야 한다\n' "$((worst - LIMIT))" >&2
	exit 1
fi
printf '\n여유 %s자 (가장 불리한 셈법 기준)\n' "$((LIMIT - worst))"
