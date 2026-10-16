#!/usr/bin/env bash
# test_build.sh — build.sh 의 검사가 실제로 잡는지 실패를 주입해 확인한다.
#
#   ./test_build.sh
#
# 케이스 폴더를 /tmp 사본으로 떠서 그 안에서만 고친다. 원본 소스·build/·submit/ 은 건드리지 않는다.
# 주입 문자열(남의 이메일·전화번호)은 실행 시점에 조립한다 — 저장소에 리터럴로 두지 않는다.

set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
RESUME=$(cd "$HERE/../../resume" && pwd)
# 사본 안의 build.sh 는 자기 위치의 ../../resume 을 읽는다. 바깥 값이 끼어들지 않게 지운다.
unset APPLY_RESUME_DIR

if [ -z "${APPLY_TEX_SHELL:-}" ]; then
	exec nix develop "path:$RESUME" --command env APPLY_TEX_SHELL=1 "$0" "$@"
fi

root=$(mktemp -d /tmp/apply-build-test-XXXXXX)
pass=0
failn=0
note() { printf '%s\n' "$*"; }
fresh() { # 리포 구조를 흉내 낸 사본: <d>/resume (build/ 제외) + <d>/applications/<건> (소스만)
	local d c
	d=$(mktemp -d "$root/tree-XXXX")
	mkdir -p "$d/resume" "$d/applications"
	tar -C "$RESUME" --exclude=./build -cf - . | tar -C "$d/resume" -xf -
	c="$d/applications/$(basename "$HERE")"
	mkdir -p "$c/submit"
	# 소스만 뜬다. build/·submit/ 의 기존 산출물(사진 포함)은 사본에 들이지 않는다.
	cp -a "$HERE/application-telechips.org" "$HERE/answers.md" "$HERE/build.sh" "$c"/
	printf '%s' "$c"
}
expect() { # 기대(ok|fail) 이름 이유패턴 명령… — fail 은 기대한 이유로 실패해야 통과다
	local want=$1 name=$2 why=$3 rc=0
	shift 3
	"$@" >"$root/last.log" 2>&1 || rc=$?
	if { [ "$want" = ok ] && [ "$rc" = 0 ]; } ||
		{ [ "$want" = fail ] && [ "$rc" != 0 ] && grep -qF -- "$why" "$root/last.log"; }; then
		note "  ✓ $name (exit $rc)"
		pass=$((pass + 1))
	else
		note "  ✗ $name — 기대 $want(«$why»), exit $rc"
		sed 's/^/      /' "$root/last.log" | tail -5
		failn=$((failn + 1))
	fi
}
inject() { # 파일 앞찾기 바꿀문자열 — 첫 일치 하나만 바꾼다
	python3 - "$@" <<'PY'
import pathlib, sys
p, old, new = pathlib.Path(sys.argv[1]), sys.argv[2], sys.argv[3]
s = p.read_text()
assert old in s, f'주입 지점 없음: {old!r}'
p.write_text(s.replace(old, new, 1))
PY
}

at=@
other_mail="someone.else${at}example.org"
p1=010
phone="${p1}-1234-5678"
synthetic_birth=1900.01.01

note "build.sh 실패 주입 — $root"

c=$(fresh)
expect ok '기준선 review' '' "$c/build.sh" review "$root/out-base"
expect fail '인자 없음' 'review' "$c/build.sh"
expect fail '출력 폴더가 submit/ 아래' 'submit/' "$c/build.sh" review "$c/submit/new"
if [ -e "$c/submit/new" ]; then
	note '  ✗ 거절하면서 submit/ 아래에 폴더를 만들었다'; failn=$((failn + 1))
else
	note '  ✓ 거절 시 submit/ 아래에 아무것도 만들지 않음'; pass=$((pass + 1))
fi
mkdir -p "$root/nonempty" && : >"$root/nonempty/keep"
expect fail '출력 폴더가 비어 있지 않음' '비어 있지 않다' "$c/build.sh" review "$root/nonempty"
expect fail 'final 에 생년월일 없음' '생년월일 입력이 없다' bash -c "'$c/build.sh' final '$root/out-f1' </dev/null"
expect fail 'final 에 형식이 틀린 생년월일' '형식이 아니다' bash -c "echo 1999-13-40 | '$c/build.sh' final '$root/out-f2'"
if grep -q '1999-13-40' "$root/last.log"; then
	note '  ✗ 오류 메시지가 입력값을 찍었다'; failn=$((failn + 1))
else
	note '  ✓ 오류 메시지에 입력값 없음'; pass=$((pass + 1))
fi
expect ok 'final 합성 생년월일' '' bash -c "echo $synthetic_birth | '$c/build.sh' final '$root/out-final'"
if grep -q "$synthetic_birth" "$root/last.log"; then
	note '  ✗ 빌드 로그가 생년월일 값을 찍었다'; failn=$((failn + 1))
else
	note '  ✓ 빌드 로그에 생년월일 값 없음'; pass=$((pass + 1))
fi
if [ -f "$root/out-final/KimJunghan_Telechips_Application.pdf" ] && [ ! -e "$root/out-final/KimJunghan_Telechips_Application_REVIEW.pdf" ]; then
	note '  ✓ final 파일명에 _REVIEW 없음'; pass=$((pass + 1))
else
	note '  ✗ final 파일명이 기대와 다르다'; failn=$((failn + 1))
fi

body() { printf '%s' "$1/../../resume/body.org"; }

c=$(fresh); inject "$(body "$c")" '- *SKS 허브* — ' '- *SKS 허브* — [email removed] '
expect fail '정제 placeholder' 'placeholder' "$c/build.sh" review "$root/out-1"

c=$(fresh); inject "$(body "$c")" '- *SKS 허브* — ' "- *SKS 허브* — $other_mail "
expect fail '정본이 아닌 이메일' '정본이 아닌 이메일' "$c/build.sh" review "$root/out-2"

c=$(fresh); inject "$c/application-telechips.org" '입사 후에는 먼저' "연락처 $phone. 입사 후에는 먼저"
expect fail '전화번호' '전화번호' "$c/build.sh" review "$root/out-3"

c=$(fresh); inject "$c/application-telechips.org" '입사 후에는 먼저' '희망 연봉은 협의합니다. 입사 후에는 먼저'
expect fail '연봉 정보' '연봉' "$c/build.sh" review "$root/out-4"

c=$(fresh); inject "$(body "$c")" '부팅 레인은 보드의 물리 스위치와' '텔레칩스에 맞춘 문장. 부팅 레인은 보드의 물리 스위치와'
expect fail '사실 정본(포트폴리오 절)에 지원처 이름' '지원처 이름' "$c/build.sh" review "$root/out-5"

c=$(fresh); inject "$c/../../resume/resume.org" '* 공개 증거' $'* 텔레칩스 조준 절\n\n* 공개 증거'
expect fail '국문 기본 뷰에 지원처 이름' '지원처 이름' "$c/build.sh" review "$root/out-6"

c=$(fresh); inject "$c/application-telechips.org" '입사 후에는 먼저' 'Technical Stack 표를 봅니다. 입사 후에는 먼저'
expect fail '영문 절 표제 누출' '영문 절 표제' "$c/build.sh" review "$root/out-7"

c=$(fresh); inject "$c/application-telechips.org" '입사 후에는 먼저' '검토본 문장이 남았습니다. 입사 후에는 먼저'
expect fail 'final 에 검토본 표지 잔존' '검토본 표지가 남았다' bash -c "echo $synthetic_birth | '$c/build.sh' final '$root/out-8'"

c=$(fresh); inject "$c/application-telechips.org" $'#+latex_header: \\def\\cvpersonal{생년월일 @@APPLY_PRIVATE_BIRTH_DATE@@}\n#+INCLUDE: "../../resume/resume.org"\n' $'#+INCLUDE: "../../resume/resume.org"\n#+latex_header: \\def\\cvpersonal{생년월일 @@APPLY_PRIVATE_BIRTH_DATE@@}\n'
expect fail 'INCLUDE 뒤 키워드가 제외 절에 삼켜짐' 'tex 에 생년월일 마커가 없다' "$c/build.sh" review "$root/out-9"

c=$(fresh); inject "$c/application-telechips.org" '* 지원 동기와 입사 후 계획' '** 지원 동기와 입사 후 계획'
expect fail '지원처층 절이 제외 절 아래로 들어감' '지원처층 절이 빠졌다' "$c/build.sh" review "$root/out-10"

c=$(fresh); inject "$c/application-telechips.org" '입사 후에는 먼저' '펌웨어 계약 밖에서 서버와 앱까지 만들었습니다. 입사 후에는 먼저'
expect fail '철회된 주장' '철회된 주장' "$c/build.sh" review "$root/out-11"

c=$(fresh); inject "$c/application-telechips.org" '생년월일 @@APPLY_PRIVATE_BIRTH_DATE@@' '생년월일 미정'
expect fail '생년월일 마커 삭제' '생년월일 마커가 없다' "$c/build.sh" review "$root/out-12"

for d in "$root"/out-1 "$root"/out-2 "$root"/out-9 "$root"/out-10; do
	if [ -n "$(ls -A "$d" 2>/dev/null)" ]; then
		note "  ✗ 실패한 빌드가 $d 에 산출물을 남겼다"; failn=$((failn + 1))
	fi
done

note "통과 $pass · 실패 $failn — 작업 사본 $root"
[ "$failn" = 0 ]
