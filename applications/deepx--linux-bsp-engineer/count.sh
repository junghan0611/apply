#!/usr/bin/env bash
# count.sh — form-answers.md 의 ```text 블록들을 세어 상한을 넘는지 본다.
#
#   ./count.sh
#
# 이 건의 서술형은 3.1 하나(상한 300자)이고 본안·대체안 두 블록이 있다. 둘 다 센다.
# 바이트가 아니라 글자로 센다 — 한글은 UTF-8 로 3바이트다.

set -euo pipefail
cd "$(dirname "$0")"

LIMIT=300
fail=0

# ```text 블록을 순서대로 뽑는다.
mapfile -t blocks < <(awk '
	/^```text$/ { inb = 1; buf = ""; next }
	/^```$/     { if (inb) { gsub(/\n$/, "", buf); printf "%s\n", buf; inb = 0 } ; next }
	inb         { buf = buf $0 }
' form-answers.md)

[ "${#blocks[@]}" -gt 0 ] || { echo 'form-answers.md 에서 ```text 블록을 찾지 못했다' >&2; exit 1; }

labels=('3.1 본안 (8주 이내)' '3.1 대체안 (4주 이내)')

for i in "${!blocks[@]}"; do
	n=$(printf '%s' "${blocks[$i]}" | wc -m | tr -d ' ')
	label=${labels[$i]:-"블록 $((i + 1))"}
	if [ "$n" -gt "$LIMIT" ]; then
		printf '⚠ %-22s %4s자  (상한 %s — %s자 초과)\n' "$label" "$n" "$LIMIT" "$((n - LIMIT))" >&2
		fail=1
	else
		printf '   %-22s %4s자  (여유 %s자)\n' "$label" "$n" "$((LIMIT - n))"
	fi
done

exit "$fail"
