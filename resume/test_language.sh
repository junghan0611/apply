#!/usr/bin/env bash
# test_language.sh — latex-export.el 의 언어 선택·제외 계약이 실제로 멈추는지 실패를 주입해 본다.
#
#   ./test_language.sh
#
# resume/ 를 /tmp 사본으로 떠서 그 안에서만 고치고 org → tex 까지만 돌린다(조판 없음).
# 정본 소스·build/ 는 건드리지 않는다. 끝단 PDF 검사는 ./run.sh verify 가 맡는다.

set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
root=$(mktemp -d /tmp/resume-lang-test-XXXXXX)
pass=0
failn=0

fresh() { # build/ 를 뺀 resume/ 사본
	local d
	d=$(mktemp -d "$root/case-XXXX")
	tar -C "$HERE" --exclude=./build -cf - . | tar -C "$d" -xf -
	printf '%s' "$d"
}
export_tex() { # 사본 정본 출력 — 성공은 비어 있지 않은 tex 까지다
	emacs -Q --batch --script "$1/pipeline/latex-export.el" "$1/$2" "$root/$3.tex" && [ -s "$root/$3.tex" ]
}
pdf_text() { # 사본 PDF → 텍스트 (조판 devshell)
	(cd "$1" && nix develop 'path:.' --command pdftotext -layout "build/$2.pdf" -) 2>/dev/null
}
expect() { # ok|fail 이름 이유 명령…
	local want=$1 name=$2 why=$3 rc=0
	shift 3
	"$@" >"$root/last.log" 2>&1 || rc=$?
	# emacs --script 는 오류에도 0 이 아닐 수 있어 산출물 유무까지 본다(run.sh 와 같은 판정).
	if { [ "$want" = ok ] && [ "$rc" = 0 ]; } ||
		{ [ "$want" = fail ] && [ "$rc" != 0 ] && grep -qF -- "$why" "$root/last.log"; }; then
		echo "  ✓ $name"
		pass=$((pass + 1))
	else
		echo "  ✗ $name — 기대 $want(«$why»), exit $rc"
		tail -3 "$root/last.log" | sed 's/^/      /'
		failn=$((failn + 1))
	fi
}
inject() { # 파일 앞 뒤 — 첫 일치 하나만 바꾼다
	python3 - "$@" <<'PY'
import pathlib, sys
p, old, new = pathlib.Path(sys.argv[1]), sys.argv[2], sys.argv[3]
s = p.read_text()
assert old in s, f'주입 지점 없음: {old!r}'
p.write_text(s.replace(old, new, 1))
PY
}
probe() { # 사본에 탐침 정본을 만든다: 디렉터리 이름 언어 제외태그
	cat >"$1/targets/$2.org" <<EOF
#+cv_pdf_name: Probe
#+CV_LANG: $3
#+EXCLUDE_TAGS: $4
#+INCLUDE: "../pipeline/preamble.org"
#+INCLUDE: "../body.org" :minlevel 1
EOF
}

echo "언어 선택 실패 주입 — $root"

c=$(fresh)
expect ok '기준선 영문 베이스' '' export_tex "$c" resume-en.org base

c=$(fresh); inject "$c/targets/embedded-software-engineer.org" $'#+CV_LANG: en\n' ''
expect fail 'CV_LANG 누락' 'CV_LANG must be exactly one' export_tex "$c" targets/embedded-software-engineer.org t1

c=$(fresh); inject "$c/targets/embedded-software-engineer.org" '#+CV_LANG: en' '#+CV_LANG: jp'
expect fail 'CV_LANG 허용값 밖' 'CV_LANG must be exactly one' export_tex "$c" targets/embedded-software-engineer.org t2

c=$(fresh); inject "$c/targets/embedded-software-engineer.org" '#+CV_LANG: en' $'#+CV_LANG: en\n#+CV_LANG: ko'
expect fail 'CV_LANG 두 값' 'CV_LANG must be exactly one' export_tex "$c" targets/embedded-software-engineer.org t3

c=$(fresh); inject "$c/targets/embedded-software-engineer.org" '#+EXCLUDE_TAGS: noexport ' '#+EXCLUDE_TAGS: '
expect fail 'EXCLUDE_TAGS 에 noexport 누락' 'must include noexport' export_tex "$c" targets/embedded-software-engineer.org t4

c=$(fresh); inject "$c/body.org" $'\n#+end_en\n' $'\n'
expect fail '닫히지 않은 블록' 'block under' export_tex "$c" resume.org t5

c=$(fresh); inject "$c/body.org" $'\n#+end_en\n' $'\n#+end_ko\n'
expect fail '짝이 틀린 블록' 'mismatched #+end_ko' export_tex "$c" resume.org t6

c=$(fresh); inject "$c/body.org" $'\n#+end_en\n' $'\n#+end_en\n#+begin_en\nDUPLICATE\n#+end_en\n'
expect fail '같은 언어 블록 중복' 'duplicate en block' export_tex "$c" resume.org t7

c=$(fresh); inject "$c/body.org" $'\n#+end_en\n' $'\n#+end_en\n#+begin_jp\nX\n#+end_jp\n'
expect fail 'ko·en 밖 언어 블록' 'unknown language block' export_tex "$c" resume.org t8

c=$(fresh); probe "$c" probe-ko ko 'noexport catalog corpus'
expect fail '국문 번역 없는 영문 표제 — 무음 대체 없음' 'TITLE_KO missing' export_tex "$c" targets/probe-ko.org t9

c=$(fresh); printf '\n* Internal memo :noexport:\n:PROPERTIES:\n:TITLE_LANG: en\n:END:\nSENTINEL_NOEXPORT_QZX8 hidden.\n' >>"$c/body.org"
expect ok 'noexport 서브트리 (번역 요구 없음)' '' export_tex "$c" resume-en.org t10
if [ ! -s "$root/t10.tex" ] || grep -q 'SENTINEL_NOEXPORT_QZX8\|Internal memo' "$root/t10.tex"; then
	echo '  ✗ noexport 센티넬이 tex 에 나왔거나 tex 가 없다'; failn=$((failn + 1))
else
	echo '  ✓ noexport 센티넬 tex 부재'; pass=$((pass + 1))
fi

c=$(fresh)
expect ok '영문 컷 export' '' export_tex "$c" targets/embedded-software-engineer.org t11
if [ ! -s "$root/t11.tex" ] || grep -qE 'begin\{(ko|en)\}|TITLE_(LANG|KO|EN)|CV_(PERIOD|WHEN)' "$root/t11.tex"; then
	echo '  ✗ 언어 블록·속성 이름이 tex 에 샜거나 tex 가 없다'; failn=$((failn + 1))
else
	echo '  ✓ 블록 래퍼·속성 이름 누출 없음'; pass=$((pass + 1))
fi

# ── 국문 뷰 ────────────────────────────────────────────────────────────────
c=$(fresh)
expect ok '국문 기본 뷰 export' '' export_tex "$c" resume.org k1
expect ok '국문 포트폴리오 export' '' export_tex "$c" portfolio-ko.org k2

c=$(fresh); inject "$c/resume.org" '#+CV_GOQUAL_MODULES: smart-hub on-device-ai' '#+CV_GOQUAL_MODULES: smart-hub domain-agents'
expect fail '국문 블록 없는 모듈 선택' 'TITLE_KO missing' export_tex "$c" resume.org k3

c=$(fresh); inject "$c/body.org" $'#+end_ko

#+begin_en
' $'#+end_ko

Stray English sentence outside blocks.

#+begin_en
'
expect fail '영문 표제 절의 블록 밖 문장 (국문 뷰)' 'text outside #+begin_ko' export_tex "$c" resume.org k4

c=$(fresh); inject "$c/body.org" ':TITLE_KO: 스마트홈 허브 — 펌웨어에서 제품까지' ':TITLE_X: 없음'
expect fail '국문 표제 누락' 'TITLE_KO missing' export_tex "$c" resume.org k5

c=$(fresh); inject "$c/resume.org" '#+EXCLUDE_TAGS: noexport independent' '#+EXCLUDE_TAGS: independent'
expect fail '국문 뷰 EXCLUDE_TAGS noexport 누락' 'must include noexport' export_tex "$c" resume.org k6

# ── 끝단 PDF: 언어 센티넬 · 모듈 순서 · 제외 절 ─────────────────────────────
c=$(fresh)
inject "$c/body.org" '- *SKS 허브* — ' '- *SKS 허브* — QZXKO1 '
inject "$c/body.org" '- *SKS Hub* — ' '- *SKS Hub* — QZXEN1 '
inject "$c/body.org" '내보내지 않는 절이다.' 'QZXNOEXPORT 내보내지 않는 절이다.'
inject "$c/body.org" 'The claims above rest on' 'QZXCORPUS The claims above rest on'
if (cd "$c" && ./run.sh ko >/dev/null 2>&1 && ./run.sh target embedded-software-engineer >/dev/null 2>&1); then
	ko_txt=$(pdf_text "$c" KimJunghan_CV_KO)
	pf_txt=$(pdf_text "$c" KimJunghan_Portfolio_KO)
	en_txt=$(pdf_text "$c" KimJunghan_Resume_Embedded_Software_Engineer)
	check() { # 이름 조건
		if eval "$2"; then echo "  ✓ $1"; pass=$((pass + 1)); else echo "  ✗ $1"; failn=$((failn + 1)); fi
	}
	check 'PDF 국문 이력서에 국문 센티넬' 'grep -q QZXKO1 <<<"$ko_txt"'
	check 'PDF 국문 이력서에 영문 센티넬 없음' '! grep -q QZXEN1 <<<"$ko_txt"'
	check 'PDF 영문 컷에 영문 센티넬' 'grep -q QZXEN1 <<<"$en_txt"'
	check 'PDF 영문 컷에 국문 센티넬 없음' '! grep -q QZXKO1 <<<"$en_txt"'
	check 'PDF 세 문서에 noexport·corpus 센티넬 없음' '! grep -qE "QZXNOEXPORT|QZXCORPUS" <<<"$ko_txt$pf_txt$en_txt"'
	check 'PDF 국문 모듈 순서 = 정본 목록(smart-hub → on-device-ai)' \
		'[ "$(grep -n -m1 "스마트홈 허브" <<<"$ko_txt" | cut -d: -f1)" -lt "$(grep -n -m1 "온디바이스" <<<"$ko_txt" | cut -d: -f1)" ]'
	check 'PDF 국문 문서에 블록 표지·속성 이름 없음' '! grep -qE "begin_(ko|en)|end_(ko|en)|TITLE_(LANG|KO|EN)|CV_(PERIOD|WHEN|LANG)" <<<"$ko_txt$pf_txt"'
	check 'PDF 포트폴리오에 경력·자기소개 절 없음(제외 태그)' '! grep -qE "^ *(경력|자기소개)$" <<<"$pf_txt"'
else
	echo '  ✗ 끝단 PDF 빌드 실패'; failn=$((failn + 1))
fi

echo "통과 $pass · 실패 $failn — 작업 사본 $root"
[ "$failn" = 0 ]
