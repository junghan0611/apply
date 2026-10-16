#!/usr/bin/env bash
# 이력서·포트폴리오 — Org 정본 → XeLaTeX → PDF (국문·영문)
#
# 하나의 공통 사실원(body.org, 국문·영문 블록)과 여러 정본(뷰)이 한 벌의 조판 선언을 공유한다.
# 경력 사실은 body.org에서만 고치고, 뷰는 #+CV_LANG 으로 언어를, CV_*_MODULES·EXCLUDE_TAGS 로
# 선택·순서를, 짧은 요약과 공개 증거 입구를 쥔다 — 사실 SSOT와 표시 SSOT를 혼동하지 않는다.
#
#   resume.org (국문 기본) ─┐
#   resume-en.org (영문 베이스) ┤
#   portfolio-ko.org (국문 포트) ┼→ latex-export.el(org→tex, 언어 선택) → xelatex → build/<name>.pdf
#   targets/*.org (영문 컷) ─────┘   article · A4 · Pretendard/D2Coding
#
# 도구 출처: emacs 는 호스트 전역(NixOS). 조판(texlive)과 활자(Pretendard·D2Coding)는 이
#   디렉터리의 flake devshell 이 쥔다 — 활자가 다르면 같은 소스에서 다른 문서가 나온다.
#   flake 는 `path:.` 로 부른다. git 에 add 되지 않은 파일도 보이게 하기 위해서다(순수
#   flake 참조는 워킹트리의 untracked 파일을 못 본다).
#
# 사용법:
#   ./run.sh check              # 도구·활자 점검
#   ./run.sh base               # 베이스 이력서 둘 (국문 resume.org · 영문 resume-en.org)
#   ./run.sh ko                 # 국문 둘 (resume.org · portfolio-ko.org)
#   ./run.sh target ai-engineer # targets/ai-engineer.org 한 장
#   ./run.sh all                # 정본 전부 + 검수 (기대 산출물 집합까지)
#   ./run.sh verify             # 산출물 검수
#   ./run.sh clean              # 중간산물 정리
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PIPE="$DIR/pipeline"
BUILD="$DIR/build"
EXPORT_EL="$PIPE/latex-export.el"
BASE_PDF_NAME="KimJunghan_Resume"

GREEN='\033[0;32m'; RED='\033[0;31m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; NC='\033[0m'
info() { echo -e "${BLUE}[INFO]${NC} $*"; }
ok()   { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
err()  { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# 조판 도구는 PATH 로 대체하지 않는다. 호스트 texlive 판과 활자가 다르면 같은 소스에서
# 다른 문서가 나오기 때문이다. flake 가 FONTCONFIG_FILE 을 고정해 호스트 폰트 캐시를
# 상속하지 않게 한다.
NIXRUN() {
	command -v nix >/dev/null 2>&1 || {
		err "nix 없음 — PDF 조판은 flake devshell(texlive·Pretendard·D2Coding)이 필요합니다."; return 127; }
	( cd "$DIR" && nix develop 'path:.' --command "$@" )
}

# 이 레인의 정본(뷰) 전부. 국문 기본 뷰(resume.org)·영문 베이스(resume-en.org)·국문 포트폴리오
# (portfolio-ko.org)·영문 타깃 컷(targets/*.org). verify 는 이 목록이 정하는 산출물 집합을 기대한다.
views() {
	local t
	echo "$DIR/resume.org"; echo "$DIR/resume-en.org"; echo "$DIR/portfolio-ko.org"
	for t in "$DIR"/targets/*.org; do [[ -f "$t" ]] && echo "$t"; done
}

# 정본이 고른 언어(#+CV_LANG). 언어 선택 자체의 계약은 pipeline/latex-export.el 이 강제한다.
lang_of() { grep -m1 -i '^#+CV_LANG:' "$1" 2>/dev/null | sed 's/^#+[Cc][Vv]_[Ll][Aa][Nn][Gg]:[[:space:]]*//' || true; }

# 정본이 스스로 정하는 산출물 이름. 파일명에서 유추하지 않는다 — ai-engineer 를
# "Ai_Engineer" 로 만들지 않기 위해서다.
pdf_name_of() {
	local org="$1" name
	# BRE 에서 '\+' 는 리터럴 '+' 가 아니라 앞 문자의 1회 이상 반복이다. Org 키워드의
	# '#+' 를 찾으려면 '+' 를 그대로 둬야 한다.
	name="$(grep -m1 '^#+cv_pdf_name:' "$org" 2>/dev/null | sed 's/^#+cv_pdf_name:[[:space:]]*//' || true)"
	[[ -n "$name" ]] || { err "$org 에 '#+cv_pdf_name:' 이 없습니다"; return 1; }
	echo "$name"
}

cmd_check() {
	command -v emacs >/dev/null && ok "emacs: $(emacs --version | head -1)" || { err "emacs 없음"; exit 1; }
	[[ -f "$EXPORT_EL" ]]            && ok "latex-export.el 있음" || { err "$EXPORT_EL 없음"; exit 1; }
	[[ -f "$PIPE/preamble.org" ]]    && ok "preamble.org 있음"    || { err "preamble.org 없음"; exit 1; }
	[[ -f "$DIR/body.org" ]]         && ok "body.org 있음"        || { err "body.org 없음"; exit 1; }
	info "flake devshell 점검(xelatex·활자)…"
	NIXRUN bash -c 'command -v xelatex >/dev/null && command -v latexmk >/dev/null' \
		&& ok "xelatex · latexmk (flake)" || { err "flake devshell 에 조판 도구 없음"; exit 1; }
	local n; n="$(NIXRUN bash -c 'fc-list | grep -ci pretendard' 2>/dev/null || echo 0)"
	[[ "$n" -gt 0 ]] && ok "Pretendard ${n}종 (flake fontconfig)" || { err "Pretendard 없음 — flake FONTCONFIG_FILE 확인"; exit 1; }
}

# 타깃 컷은 "검증 가능"이라는 말만 하지 않고 실제 공개 입구를 보여야 한다. 이 검사는
# 새 컷을 복사하면서 Evidence 절이나 선택 manifest를 빼먹는 조용한 퇴행을 막는다.
validate_target_source() {
	local org="$1" links
	[[ "$org" == "$DIR/targets/"* ]] || return 0
	# BRE에서 \+는 리터럴 plus가 아니라 반복 연산자다. Org의 #+는 plus를 그대로 쓴다.
	grep -q '^#+CV_GOQUAL_MODULES:' "$org" \
		|| { err "$org 에 #+CV_GOQUAL_MODULES가 없습니다"; return 1; }
	grep -q '^\* Public Evidence' "$org" \
		|| { err "$org 에 Public Evidence 절이 없습니다"; return 1; }
	links="$(grep -o 'https://github.com/junghan0611/' "$org" | wc -l)"
	[[ "$links" -ge 2 ]] \
		|| { err "$org 에 공개 GitHub 증거 경로가 2개 미만입니다"; return 1; }
}

# org → tex → pdf. 정본 한 장이 PDF 한 장이 된다.
build_one() {
	local org="$1" base
	[[ -f "$org" ]] || { err "$org 없음"; exit 1; }
	validate_target_source "$org"
	base="$(pdf_name_of "$org")"
	mkdir -p "$BUILD"
	info "[$base] org → tex (emacs ox-latex, article)"
	# 지난 판을 먼저 지운다. grep 파이프가 emacs 의 종료 코드를 삼키기 때문에 "내보내기가
	# 실패했는데 이전 .tex 이 남아 있어 그대로 다시 조판되는" 상태를 파일 존재만으로는
	# 구분할 수 없다. 지우고 시작하면 아래 존재 검사가 그대로 실패 판정이 된다.
	rm -f "$BUILD/$base.tex"
	emacs -Q --batch --script "$EXPORT_EL" "$org" "$BUILD/$base.tex" 2>&1 \
		| grep -E "ERROR|Cannot open|error" || true
	[[ -f "$BUILD/$base.tex" ]] || { err "[$base] TEX 생성 실패"; exit 1; }
	info "[$base] tex → pdf (xelatex, flake devshell)"
	NIXRUN latexmk -xelatex -interaction=nonstopmode -halt-on-error \
		-output-directory="$BUILD" "$BUILD/$base.tex" >/dev/null 2>&1 \
		|| { err "[$base] xelatex 실패 — $BUILD/$base.log 확인"; exit 1; }
	local pdf="$BUILD/$base.pdf"
	[[ -f "$pdf" ]] || { err "[$base] PDF 생성 실패"; exit 1; }
	# 활자에 없는 글자는 로그에만 남고 PDF 에는 빈칸으로 찍힌다. 페이지는 멀쩡히 나오므로
	# 눈으로 세는 대신 빌드가 센다.
	local missing; missing="$(grep -c 'Missing character' "$BUILD/$base.log" || true)"
	[[ "$missing" -eq 0 ]] || { err "[$base] Missing character ${missing}건 — 활자에 없는 글자가 빈칸으로 찍혔다:"
		grep 'Missing character' "$BUILD/$base.log" | sort -u | sed 's/^/    /'; exit 1; }
	local overfull; overfull="$(grep -c 'Overfull \\hbox' "$BUILD/$base.log" || true)"
	[[ "$overfull" -eq 0 ]] || warn "[$base] Overfull hbox ${overfull}건 — 판면을 넘은 표/문단이 있다"
	local pages; pages="$(NIXRUN pdfinfo "$pdf" 2>/dev/null | awk '/^Pages/{print $2}')"
	ok "[$base] $pdf — ${pages}p, $(du -h "$pdf" | cut -f1)"
}

cmd_verify() {
	local fail=0 pdf base txt view lang
	local -A lang_by_pdf=()
	# 기대 산출물 집합 — 정본마다 PDF 한 장. 빠진 것은 실패, 정본 없는 PDF(낡은 이름)도 실패다.
	while IFS= read -r view; do
		base="$(pdf_name_of "$view")" || { fail=1; continue; }
		lang_by_pdf[$base]="$(lang_of "$view")"
		[[ -f "$BUILD/$base.pdf" ]] || { err "  기대 산출물 없음: $base.pdf ($(basename "$view"))"; fail=1; }
	done < <(views)
	shopt -s nullglob
	for pdf in "$BUILD"/*.pdf; do
		base="$(basename "$pdf" .pdf)"
		lang="${lang_by_pdf[$base]:-}"
		[[ -n "$lang" ]] || { err "  정본 없는 PDF(낡은 산출물?): $base.pdf"; fail=1; continue; }
		txt="$(NIXRUN pdftotext -layout "$pdf" - 2>/dev/null || true)"
		# nix 경유 poppler 가 드물게 성공 코드와 빈 stdout 을 돌려준 적이 있다. 빈 텍스트로
		# 검사하면 통과 여부가 실행마다 옮겨 다닌다. 한 번 재시도하고도 비면 검수를 수행한
		# 척하지 않고 명시적으로 실패한다.
		if [[ -z "${txt//[[:space:]]/}" ]]; then
			txt="$(NIXRUN pdftotext -layout "$pdf" - 2>/dev/null || true)"
		fi
		if [[ -z "${txt//[[:space:]]/}" ]]; then
			err "  PDF 텍스트 추출 실패(2회 빈 출력): $pdf"; fail=1; continue
		fi
		local pages psize
		pages="$(NIXRUN pdfinfo "$pdf" 2>/dev/null | awk '/^Pages/{print $2}')"
		echo "── $base.pdf (${pages}p, $lang) ──"
		# A4. 이력서를 인쇄하는 쪽은 A4 를 전제한다. article 은 기본이 letterpaper 라
		# geometry 호출이 빠지면 조용히 되돌아간다 — 페이지는 나오고 여백만 달라져서
		# 눈으로는 잘 안 잡힌다. pdfinfo 는 A4(595.276 x 841.89pt)를 정수로 반올림해
		# 보고하므로 ±2pt 허용으로 본다. letter(612 x 792)와는 그보다 훨씬 멀다.
		psize="$(NIXRUN pdfinfo "$pdf" 2>/dev/null | awk '/^Page size/{print $3, $5}')"
		if awk -v s="$psize" 'BEGIN{split(s,d," "); exit !(d[1]>593 && d[1]<598 && d[2]>840 && d[2]<844)}'; then
			ok "  A4 판면 (${psize/ / x } pt)"
		else
			err "  A4 아님: ${psize/ / x } pt"; fail=1
		fi
		# 이력서는 읽는 사람이 훑는 문서다. 네 쪽을 넘어가면 읽히지 않는다.
		if [[ "$pages" -le 3 ]]; then ok "  분량 ${pages}쪽"
		elif [[ "$pages" -eq 4 ]]; then warn "  ${pages}쪽 — 이력서 상한선. 컷을 다듬을 것"
		else err "  ${pages}쪽 — 이력서로는 길다"; fail=1; fi
		local log="$BUILD/$base.log"
		if [[ -f "$log" ]]; then
			local miss over
			miss="$(grep -c 'Missing character' "$log" || true)"
			over="$(grep -c 'Overfull \\hbox' "$log" || true)"
			[[ "$miss" -eq 0 ]] && ok "  활자 누락 없음" || { err "  Missing character ${miss}건"; fail=1; }
			[[ "$over" -eq 0 ]] && ok "  판면 초과 없음" || warn "  Overfull hbox ${over}건"
		fi
		# set -o pipefail 아래에서 `echo "$txt" | grep -q`는 grep 조기 종료 뒤 echo가 SIGPIPE로
		# 실패해 거짓 경고를 낼 수 있다. 판정용 grep은 here-string으로 고정한다.
		# 별표 누출 — Org 굵게가 렌더 안 되고 별표로 샌 경우.
		if grep -q '[*]' <<<"$txt"; then err "  별표(*) 누출 — 굵게 렌더 실패"; fail=1; else ok "  별표 누출 없음"; fi
		# :noexport 메모 누출.
		if grep -qiE 'noexport|생성 프롬프트|IMAGE PROMPT|TODO|검토 메모' <<<"$txt"; then
			err "  :noexport 내용 누출 의심"; fail=1; else ok "  :noexport 누출 없음"; fi
		# 연락 경로가 없는 이력서는 이력서가 아니다.
		# 2026-09-20: history 정제(docs/HISTORY-REDACTION.md)가 이메일을 `[email removed]`로
		# 치환할 때 이 검사문의 grep 패턴과 preamble.org 소스가 같이 치환됐다. 그 결과 검사가
		# 「placeholder가 있으면 통과」로 뒤집혀 세 번의 게이트 통과가 전부 거짓이었다 — GLG가
		# 빌드된 PDF를 직접 열어서 잡았다. 그래서 여기는 실주소 형태를 요구하고, placeholder
		# 문자열 자체는 하드 실패로 잡는다.
		# 정제 흔적은 이메일 자리 말고도 나온다. 특정 리터럴이 아니라 형식으로 잡는다.
		if grep -qiE '\[[^]]*(removed|redacted)[^]]*\]|removed at publication' <<<"$txt"; then
			err "  정제 placeholder 노출"; fail=1
		fi
		if grep -q '\[email removed\]' <<<"$txt"; then
			err "  이메일 자리에 redaction placeholder(\`[email removed]\`) 노출 — 소스 정제됨"; fail=1
		elif grep -qE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' <<<"$txt"; then
			ok "  이메일 노출"
		else
			err "  이메일 안 보임"; fail=1
		fi
		grep -q 'github.com/junghan0611' <<<"$txt" && ok "  GitHub URL 노출" || { err "  GitHub URL 안 보임"; fail=1; }
		grep -qi 'linkedin.com/in/' <<<"$txt"      && ok "  LinkedIn URL 노출" || { err "  LinkedIn URL 안 보임"; fail=1; }
		# 공개 증거면. 이력서가 주장하는 것을 읽는 사람이 건너가 확인할 자리다 — 연락처 줄에서
		# 조용히 빠지면 제출본 전체가 그 자리를 잃는데 다른 검사는 아무것도 말하지 않는다.
		grep -q 'ax.junghanacs.com' <<<"$txt"      && ok "  AX 증거면 URL 노출" || { err "  ax.junghanacs.com 안 보임"; fail=1; }
		grep -qF 'www.junghanacs.com' <<<"$txt" && ok "  대표 홈페이지 URL 노출" || { err "  대표 홈페이지 URL 안 보임"; fail=1; }
		# 공개 증거가 PDF 텍스트에도 보여야 한다. 숨은 링크 annotation만 있으면 사람은 눌러도
		# ATS/상대 에이전트가 추출한 텍스트에서는 사라질 수 있으므로 URL 자체를 보인다.
		local evidence_links ko
		evidence_links="$(grep -o 'github.com/junghan0611/' <<<"$txt" | wc -l)"
		[[ "$evidence_links" -ge 2 ]] && ok "  공개 증거 URL ${evidence_links}개" \
			|| { err "  공개 증거 URL 2개 미만"; fail=1; }
		ko="$(grep -oP '[가-힣]' <<<"$txt" | wc -l)"
		if [[ "$lang" == en ]]; then
			grep -q 'Public Evidence' <<<"$txt" && ok "  Public Evidence 절" || { err "  Public Evidence 절 안 보임"; fail=1; }
			# body.org 에 국문 블록이 함께 산다. 이름 병기(김정한·GLG·힣)를 넘는 한글은 국문 블록이
			# 영문 컷으로 샌 것이다 — 2026-10-16 부터 경고가 아니라 실패다.
			[[ "$ko" -le 12 ]] && ok "  영문 문서 (한글 ${ko}자 — 이름 병기 범위)" \
				|| { err "  한글 ${ko}자 — 국문 블록이 영문 컷으로 샜다"; fail=1; }
		else
			[[ "$ko" -ge 300 ]] && ok "  국문 문서 (한글 ${ko}자)" || { err "  한글 ${ko}자 — 국문 문서가 아니다"; fail=1; }
			# 반대 방향 누출: 영문 절 표제가 국문 뷰에 나오면 TITLE_KO 대체나 제외 태그가 빠진 것이다.
			if grep -qE 'Experience|Education and Awards|Third-Party Validation|Selected Open Source|Technical Stack|Working Corpus|Independent Work' <<<"$txt"; then
				err "  영문 절 표제가 국문 문서에 샜다"; fail=1
			else
				ok "  영문 절 표제 누출 없음"
			fi
		fi
	done
	shopt -u nullglob
	[[ $fail -eq 0 ]] && ok "verify 통과" || { err "verify 실패 — 위 항목 확인"; return 1; }
}

cmd_clean() {
	rm -f "$BUILD"/*.aux "$BUILD"/*.fdb_latexmk "$BUILD"/*.fls "$BUILD"/*.out \
	      "$BUILD"/*.xdv "$BUILD"/*.log "$BUILD"/*.tex
	ok "중간산물 정리 (build/*.pdf 는 유지)"
}

cd "$DIR"
case "${1:-all}" in
	check)  cmd_check ;;
	base)   build_one "$DIR/resume.org"; build_one "$DIR/resume-en.org" ;;
	ko)     build_one "$DIR/resume.org"; build_one "$DIR/portfolio-ko.org" ;;
	target)
		[[ -n "${2:-}" ]] || { err "사용법: ./run.sh target <name>  (targets/<name>.org)"; exit 1; }
		build_one "$DIR/targets/$2.org" ;;
	all)
		while IFS= read -r v; do build_one "$v"; done < <(views)
		cmd_verify ;;
	verify) cmd_verify ;;
	clean)  cmd_clean ;;
	*) echo "사용법: ./run.sh {check|base|ko|target <name>|all|verify|clean}"; exit 1 ;;
esac
