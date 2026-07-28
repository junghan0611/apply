#!/usr/bin/env bash
# new.sh — 지원 건 하나의 자리를 만들고 원장에 행을 추가한다.
#
#   ./new.sh "회사명" "직무명" [공고URL] [경로]
#
# 경로 기본값은 "LinkedIn 원클릭". 폴더명은 <회사>--<직무> 이며 한글을 그대로 둔다.
# 이미 있는 폴더면 덮어쓰지 않고 멈춘다 — 재지원은 뒤에 --2 를 붙여 새 건으로 만든다.

set -euo pipefail

cd "$(dirname "$0")"

if [ $# -lt 2 ]; then
	printf 'usage: %s "회사명" "직무명" [공고URL] [경로]\n' "$0" >&2
	exit 2
fi

company=$1
role=$2
url=${3:-}
channel=${4:-LinkedIn 원클릭}

# 폴더명은 ASCII 소문자 하이픈으로 통일한다. 한글 폴더명은 만들지 않는다 —
# 외부 ATS 업로드·zip·CI 어디서든 깨지지 않는 이름이어야 하고, 경로를 눈으로 훑을 때
# 영문 한 벌이 읽기 쉽다. 한글 표기는 JD.md 안에 남는다.
#
# sed 대신 bash 치환을 쓴다 — ERE 브래킷 안의 중괄호가 interval 로 해석돼 깨진다.
slugify() {
	local s=$1 c out=''
	s=${s//（주）/}
	s=${s//(주)/}
	s=${s//㈜/}
	s=${s//Inc./}
	s=${s//Corp./}
	s=${s//Co., Ltd./}
	s=${s,,}
	for c in '/' '\' '(' ')' '（' '）' '[' ']' '{' '}' ',' ':' '.' '·' '&' '+' '_' ' ' '　'; do
		s=${s//"$c"/-}
	done
	# ASCII 영숫자와 하이픈만 남긴다.
	while [ -n "$s" ]; do
		c=${s:0:1}
		s=${s:1}
		case $c in
		[a-z0-9-]) out+=$c ;;
		esac
	done
	while [[ $out == *--* ]]; do out=${out//--/-}; done
	out=${out#-}
	out=${out%-}
	printf '%s' "$out"
}

c_slug=$(slugify "$company")
r_slug=$(slugify "$role")
today=$(TZ='Asia/Seoul' date '+%Y-%m-%d')

if [ -z "$c_slug" ] || [ -z "$r_slug" ]; then
	printf 'slug 가 비었다: 회사="%s" → "%s", 직무="%s" → "%s"\n' \
		"$company" "$c_slug" "$role" "$r_slug" >&2
	printf '폴더명은 영문이다. 회사명·직무명을 영문으로 준다:\n' >&2
	printf '  ./new.sh "Insighter" "AX Engineer" <URL>\n' >&2
	printf '한글 표기는 JD.md 안에 적는다.\n' >&2
	exit 2
fi

dir="$c_slug--$r_slug"

if [ -e "$dir" ]; then
	printf 'already exists: %s\n' "$dir" >&2
	printf '재지원이면 폴더명 뒤에 --2 를 붙여 별도 건으로 만든다.\n' >&2
	exit 1
fi

mkdir -p "$dir"

cat >"$dir/JD.md" <<EOF
# $company — $role

- 공고 URL: ${url:-(없음)}
- 채집일: $today
- 경로: $channel

> 아래에 **공고 본문을 원문 그대로** 붙인다. 요약하지 않는다.
> 공고는 마감되면 사라지고, 면접 준비 때 필요한 것은 원문이다.

## 공고 원문

(여기에 붙인다)

## 이 공고가 요구하는 것 — 읽고 나서 채운다

- 핵심 요구:
- 우대 사항 중 내가 대는 증거:
- 내가 대지 못하는 것 (경계):
EOF

cat >"$dir/submission.md" <<EOF
# 제출 기록 — $company / $role

| 항목 | 값 |
|---|---|
| 상태 | draft |
| 지원일 | — |
| 경로 | $channel |
| 첨부 컷 | — |
| 공고 URL | ${url:-(없음)} |

## 낸 것

- [ ] 이력서 PDF —
- [ ] 커버레터 / 지원 동기 —
- [ ] 추가 서류 —

## 폼에 답한 질문

| 질문 | 답 | 출처 |
|---|---|---|
|  |  | \`FAQ.md\` §? |

> 사전에 없던 질문은 여기 적고 **\`FAQ.md\` 에도 추가한다.**

## 왜 이 회사인가 (이 건의 글)

## 이후 기록

- [$today] 건 생성.
EOF

# 원장 표의 마지막 행 뒤에 붙인다 (표는 파일 상단, --- 구분선 앞에서 끝난다).
row="| $company | $role | draft | — | $channel | — | \`$dir\` |"
awk -v row="$row" '
	/^\| / { last = NR }
	{ lines[NR] = $0 }
	END {
		for (i = 1; i <= NR; i++) {
			print lines[i]
			if (i == last) print row
		}
	}
' LEDGER.md >LEDGER.md.tmp && mv LEDGER.md.tmp LEDGER.md

printf 'created: %s\n' "$dir"
printf '  1. JD.md 에 공고 원문을 붙인다\n'
printf '  2. 컷을 고른다 (FAQ.md §10)\n'
printf '  3. 제출은 GLG 승인 후\n'
