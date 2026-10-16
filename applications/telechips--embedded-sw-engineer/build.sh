#!/usr/bin/env bash
# build.sh — 텔레칩스 BSP 국문 업로드 서류 두 장을 Org 정본에서 만든다.
#
#   ./build.sh review <새 출력 폴더>              검토본 — 생년월일 칸은 「검토본 — 미기입」
#   ./build.sh final  <새 출력 폴더> < (생년월일)  제출본 — 생년월일 한 줄을 표준입력으로만 받는다
#
# 산출 (출력 폴더 안)
#   KimJunghan_Telechips_Application[_REVIEW].pdf  이력서 칸 — application-telechips.org
#                                                   (= resume/resume.org 국문 기본 뷰 + 이 건의 지원처층)
#   KimJunghan_Systems_BSP_Portfolio.pdf           포트폴리오 칸 — resume/portfolio-ko.org
#   form-*.txt                                     폼 텍스트 칸 후보 — answers.md 의 「## 문항 …」 text 블록
#   SHA256SUMS, SOURCES.sha256                     산출물·입력 지문
#
# 편집 입구는 resume/body.org(국문·영문 사실 정본) 하나다. resume/resume.org·portfolio-ko.org 는
# 고르기·배열·짧은 요약, application-telechips.org 는 이 건의 동기·계획과 생년월일 마커뿐이다.
#
# 계약 (2026-10-16)
# - 출력 폴더는 없거나 비어 있어야 한다. 기본 출력 경로는 없다 — 예전 판은 인자 없이 돌면 submit/ 의
#   기존 스냅샷을 덮었다. 이 케이스의 submit/·build/ 아래로는 쓰지 않는다. 검사를 통과하기 전에는
#   출력 폴더에 아무것도 놓지 않는다.
# - 생년월일은 public 소스에 값이 없다. 치환은 /tmp 작업 사본의 tex 에서만 하고, 입력값·원본 경로는
#   어떤 메시지에도 찍지 않는다.
# - 검사는 산출 PDF 텍스트를 본다: A4, 활자, 한글 분량, 영문 절 표제 누출, placeholder·빌드 마커·언어
#   표지, 정본 이메일 외 주소, 전화번호, 연봉, 자가 측정 수치, 철회된 주장, 지원처 이름(기본 뷰·사실
#   정본·포트폴리오), 지원처층 절 존재, 검토본·제출본 구분. 실패 주입 회귀검사는 test_build.sh.
#
# Org → tex 은 resume/pipeline/latex-export.el(언어·모듈 선택)이 호스트 emacs -Q 로 하고, 조판은
# resume/ 의 flake devshell 을 탄다. 사본에서 돌릴 때는 APPLY_RESUME_DIR 로 그 경로를 준다.

set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
cd "$HERE"
RESUME=$(cd "${APPLY_RESUME_DIR:-$HERE/../../resume}" && pwd)

usage() {
	sed -n '2,5p' "$0" | sed 's/^# \{0,1\}//' >&2
	exit 2
}

mode=${1:-}
out=${2:-}
case $mode in review | final) ;; *) usage ;; esac
[ -n "$out" ] || usage

if [ -z "${APPLY_TEX_SHELL:-}" ]; then
	command -v nix >/dev/null || { echo 'nix 가 없다 — 조판 환경을 세울 수 없다' >&2; exit 1; }
	exec nix develop "path:$RESUME" --command env APPLY_TEX_SHELL=1 APPLY_RESUME_DIR="$RESUME" "$0" "$@"
fi

die() { echo "✗ $*" >&2; exit 1; }

# ── 출력 경로 — 폴더를 만들기 전에 판정한다 ──────────────────────────────────
out=$(realpath -m -- "$out")
case $out/ in "$HERE"/submit/* | "$HERE"/build/*) die "케이스의 submit/·build/ 아래로는 쓰지 않는다 — 새 /tmp 폴더를 지정한다" ;; esac
if [ -e "$out" ] && [ -n "$(ls -A -- "$out")" ]; then
	die "출력 폴더가 비어 있지 않다 — 기존 산출물을 덮지 않는다: $out"
fi

APP_ORG=application-telechips.org
PORT_ORG=$RESUME/portfolio-ko.org
EXPORT_EL=$RESUME/pipeline/latex-export.el
MARKER='@@APPLY_PRIVATE_BIRTH_DATE@@'
REVIEW_TEXT='검토본 — 미기입'
COMPANIES='Telechips|텔레칩스|DEEPX|딥엑스|XCENA|엑시나|Bear Robotics|Sonatus|Telit'
OWNER_EMAIL=$(grep -oE 'mailto:[^}]+' "$RESUME/pipeline/preamble.org" | head -1 | cut -d: -f2)
[ -n "$OWNER_EMAIL" ] || die '정본 이메일을 preamble.org 에서 읽지 못했다'

for f in "$APP_ORG" "$PORT_ORG" "$EXPORT_EL" "$RESUME/resume.org" "$RESUME/body.org" answers.md; do
	[ -f "$f" ] || die "소스가 없다: $f"
done
grep -qF -- "$MARKER" "$APP_ORG" || die "지원처층에 생년월일 마커가 없다"
command -v emacs >/dev/null || die 'emacs 가 없다'
kpsewhich xetexko.sty >/dev/null || die 'xetexko 가 없다'
case $(fc-list : family | tr ',' '\n') in *Pretendard*) ;; *) die 'Pretendard 활자가 없다' ;; esac

# 지원처 중립 — 기본 뷰·사실 정본·포트폴리오 뷰에 지원처 이름이 들어가면 다른 건에 그대로 못 쓴다.
# Org 주석 줄(#)은 PDF 에 나가지 않으므로 뺀다.
for f in "$RESUME/body.org" "$RESUME/resume.org" "$PORT_ORG"; do
	if grep -v '^[[:space:]]*#' "$f" | grep -qE "$COMPANIES"; then
		die "$(basename "$f") 에 지원처 이름이 있다 — 지원처층으로 옮긴다"
	fi
done

# ── 생년월일 ─────────────────────────────────────────────────────────────────
if [ "$mode" = final ]; then
	if [ -t 0 ]; then
		printf '생년월일 (YYYY.MM.DD, 화면에 표시하지 않음): ' >&2
		IFS= read -rs birth || birth=
		echo >&2
	else
		IFS= read -r birth || true
	fi
	birth=${birth//[[:space:]]/}
	[ -n "$birth" ] || die '생년월일 입력이 없다 — final 은 표준입력으로 한 줄을 받는다'
	if [[ $birth =~ ^((19|20)[0-9]{2})[-./](0[1-9]|1[0-2])[-./](0[1-9]|[12][0-9]|3[01])$ ]]; then
		fill="${BASH_REMATCH[1]}.${BASH_REMATCH[3]}.${BASH_REMATCH[4]}"
	else
		die '생년월일 형식이 아니다 (YYYY.MM.DD) — 입력값은 출력하지 않는다'
	fi
	unset birth
	app_name=KimJunghan_Telechips_Application.pdf
else
	fill=$REVIEW_TEXT
	app_name=KimJunghan_Telechips_Application_REVIEW.pdf
fi
port_name=KimJunghan_Systems_BSP_Portfolio.pdf

mkdir -p -- "$out"
work=$(mktemp -d /tmp/apply-build-XXXXXX)
chmod 700 "$work"
trap 'rm -rf "$work"' EXIT

# ── Org → tex → pdf ──────────────────────────────────────────────────────────
stage="$work/out"
mkdir -p "$stage"
to_tex() { # org tex
	emacs -Q --batch --script "$EXPORT_EL" "$1" "$2" >"$work/emacs.log" 2>&1 ||
		{ grep -iE 'error' "$work/emacs.log" | tail -3 >&2; die "Org → tex 실패: $(basename "$1")"; }
	[ -s "$2" ] || die "tex 가 비었다: $(basename "$1")"
}
to_tex "$HERE/$APP_ORG" "$work/app.tex"
to_tex "$PORT_ORG" "$work/port.tex"
grep -qF -- "$MARKER" "$work/app.tex" || die 'tex 에 생년월일 마커가 없다 — 지원처층이 \cvpersonal 을 다시 정의하지 못했다'
# 값은 숫자·마침표로 검증됐거나 고정 문구라 구분자와 충돌하지 않는다.
sed -i "s|$MARKER|$fill|g" "$work/app.tex"
unset fill

to_pdf() { # tex 업로드이름
	latexmk -xelatex -interaction=nonstopmode -halt-on-error -output-directory="$work" "$1" >/dev/null 2>&1 ||
		die "xelatex 실패: $(basename "$1")"
	local log="${1%.tex}.log" miss
	miss=$(grep -c 'Missing character' "$log" || true)
	[ "$miss" -eq 0 ] || die "활자에 없는 글자 ${miss}건: $(basename "$1")"
	cp -- "${1%.tex}.pdf" "$stage/$2"
}
to_pdf "$work/app.tex" "$app_name"
to_pdf "$work/port.tex" "$port_name"

# ── 폼 텍스트 칸 ─────────────────────────────────────────────────────────────
python3 - "$stage" <<'PY'
import pathlib, re, sys
out = pathlib.Path(sys.argv[1])
src = pathlib.Path('answers.md').read_text()
# ../stage.py 의 answer_blocks() 와 같은 계약: 「## 문항 …」 제목 아래 첫 text 블록.
blocks = re.findall(r'^## (문항 [^\n]+)\n(?:(?!^## ).)*?^```text\n(.*?)^```', src, re.S | re.M)
if not blocks:
    sys.exit('✗ answers.md 에 「## 문항 …」 text 블록이 없다')
for i, (head, body) in enumerate(blocks, 1):
    name = f'form-{i:02d}.txt'
    (out / name).write_text(body)
    print(f'  {name}  {len(body.rstrip(chr(10)))}자  ← {head.strip()}')
PY

# ── 산출물 검사 ──────────────────────────────────────────────────────────────
fail=0
bad() { echo "✗ $1: $2" >&2; fail=1; }

check_pdf() { # pdf 역할(app|port)
	local pdf=$1 role=$2 name txt pages psize emails e
	name=$(basename "$pdf")
	pages=$(pdfinfo "$pdf" | awk '/^Pages:/ {print $2}')
	[[ $pages =~ ^[0-9]+$ ]] || { bad "$name" '쪽수를 읽지 못했다'; return 0; }
	printf '%s %s쪽\n' "$name" "$pages"
	[ "$pages" -le 6 ] || echo "⚠ $name 이 6쪽을 넘는다" >&2
	psize=$(pdfinfo "$pdf" | awk '/^Page size/ {print $3, $5}')
	awk -v s="$psize" 'BEGIN{split(s,d," "); exit !(d[1]>593 && d[1]<598 && d[2]>840 && d[2]<844)}' ||
		bad "$name" "A4 가 아니다 ($psize pt)"
	if pdffonts "$pdf" | awk 'NR>2 && $(NF-4)!="yes"' | grep -q .; then
		bad "$name" '임베딩되지 않은 활자가 있다'
	fi
	txt=$(pdftotext -layout "$pdf" -)
	[ "$(perl -CSD -ne '$n += () = /\p{Hangul}/g; END { print $n + 0 }' <<<"$txt")" -ge 300 ] ||
		bad "$name" '한글이 거의 없다 — 국문 문서가 아니거나 활자가 대체됐다'
	for needle in '김정한' 'RISC-V' 'www.junghanacs.com' 'github.com/junghan0611'; do
		grep -qF "$needle" <<<"$txt" || bad "$name" "«$needle» 없음"
	done
	if grep -qE 'Experience|Education and Awards|Third-Party Validation|Selected Open Source|Technical Stack|Working Corpus|Independent Work' <<<"$txt"; then
		bad "$name" '영문 절 표제가 국문 문서에 샜다'
	fi
	# 정제·편집 흔적. 형식으로 잡는다 — 특정 치환 리터럴만 박으면 정제가 검사문까지 바꾼다.
	if grep -qiE '\[[^]]*(removed|redacted)[^]]*\]|removed at publication|@@APPLY_|\bTODO\b|\bTBD\b|begin_(ko|en)|TITLE_(LANG|KO|EN)|CV_(LANG|PERIOD|WHEN)' <<<"$txt"; then
		bad "$name" 'placeholder·빌드 마커·언어 표지가 남았다'
	fi
	emails=$(grep -oE '[[:alnum:]._%+-]+@[[:alnum:].-]+\.[[:alpha:]]{2,}' <<<"$txt" | sort -u || true)
	for e in $emails; do [ "$e" = "$OWNER_EMAIL" ] || bad "$name" '정본이 아닌 이메일 주소가 있다'; done
	grep -qF "$OWNER_EMAIL" <<<"$txt" || bad "$name" '정본 이메일이 없다'
	if grep -qE '01[016789][-. ]?[0-9]{3,4}[-. ]?[0-9]{4}' <<<"$txt"; then bad "$name" '전화번호로 보이는 문자열'; fi
	if grep -qiE '연봉|희망 ?급여|만 ?원|salary' <<<"$txt"; then bad "$name" '연봉 정보는 제외한다(폼 안내)'; fi
	for banned in '45.4' '5.8 s' '816' '246 MiB' '96%' '2,945'; do
		grep -qF "$banned" <<<"$txt" && bad "$name" "자가 측정 수치 «$banned»"
	done
	# 2026-10-15 정정된 과장: 회사 계약 밖에서 서버·앱을 만들어 납품했다는 서사.
	if grep -qiE 'contract stopped at firmware|did not cover|계약 밖|펌웨어에서 서버와 앱으로|서버와 앱까지' <<<"$txt"; then
		bad "$name" '철회된 주장(서버·앱 납품 서사)'
	fi
	if [ "$role" = port ]; then
		grep -qE "$COMPANIES" <<<"$txt" && bad "$name" '포트폴리오(지원처 중립)에 지원처 이름'
	else
		grep -qF '지원 동기와 입사 후 계획' <<<"$txt" || bad "$name" '지원처층 절이 빠졌다'
		grep -qF '자기소개' <<<"$txt" || bad "$name" '자기소개서 절이 빠졌다'
		grep -qF '학력' <<<"$txt" || bad "$name" '학력 절이 빠졌다'
		if [ "$mode" = review ]; then
			grep -qE '생년월일[[:space:]]+검토본[[:space:]]*—[[:space:]]*미기입' <<<"$txt" || bad "$name" '검토본 표지가 없다'
		else
			grep -qE '검토본|미기입' <<<"$txt" && bad "$name" '제출본에 검토본 표지가 남았다'
			grep -qE '생년월일[[:space:]]+(19|20)[0-9]{2}\.[01][0-9]\.[0-3][0-9]' <<<"$txt" || bad "$name" '생년월일 칸이 채워지지 않았다'
		fi
	fi
	return 0
}
check_pdf "$stage/$app_name" app
check_pdf "$stage/$port_name" port
[ "$fail" = 0 ] || die '검사 실패 — 출력 폴더에 아무것도 쓰지 않았다'

cp -- "$stage"/* "$out"/
( cd "$out" && sha256sum -- *.pdf form-*.txt > SHA256SUMS )
sha256sum "$APP_ORG" answers.md build.sh > "$out/SOURCES.sha256"
( cd "$RESUME" && sha256sum body.org resume.org portfolio-ko.org pipeline/latex-export.el pipeline/preamble.org flake.lock ) |
	sed 's|  |  resume/|' >> "$out/SOURCES.sha256"
echo "✓ $mode 산출 — $out"
