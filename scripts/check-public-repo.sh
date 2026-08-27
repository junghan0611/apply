#!/usr/bin/env bash
# check-public-repo.sh — 공개 저장소 자체를 검사한다. 현재 트리가 아니라
# **모든 reachable blob · path · commit metadata**를 본다.
#
#   ./scripts/check-public-repo.sh [<repo>]
#
# 왜 현재 트리만으로 부족한가: 이 저장소의 공개 계약은 전체 history 를 정제해서 그대로
# 싣는 것이다(PUBLICATION.md). `.gitignore` 를 고치거나 파일을 지우는 것은 옛 커밋의
# blob 을 지우지 않는다. 그러니 게이트도 history 를 봐야 한다.
#
# 이 스크립트는 **탐지된 값을 출력하지 않는다.** path 와 범주와 건수만 찍는다.
# 실제 값이 필요하면 로컬 private report 에서 본다. 게이트 자체가 누출면이 되면 안 된다.
set -euo pipefail

repo=$(cd "${1:-.}" && pwd)
cd "$repo"
fail=0

ok()  { printf '[OK] %s\n' "$*"; }
bad() { printf '[ERROR] %s\n' "$*" >&2; fail=1; }

git rev-parse --git-dir >/dev/null 2>&1 || { printf '%s 는 git 저장소가 아니다\n' "$repo" >&2; exit 2; }

# 커밋이 없으면 모든 검사가 "[OK] 없음"으로 통과한다. 그건 깨끗한 게 아니라 볼 것이 없는
# 것이다. 빈 판을 통과로 읽으면 게이트가 가장 위험한 순간(clone 실패·잘못된 경로)에 초록불이 된다.
git rev-parse --verify HEAD >/dev/null 2>&1 || { printf '커밋이 없다 — 검사할 것이 없는 것을 통과로 읽지 않는다\n' >&2; exit 2; }
commit_count=$(git rev-list --all --count)
[ "$commit_count" -ge 1 ] || { printf '커밋 0 — 미검사\n' >&2; exit 2; }

# 스캐너가 없으면 모든 검사가 조용히 "없음"으로 통과한다. 그건 통과가 아니라 미검사다.
for tool in rg git; do
	command -v "$tool" >/dev/null || { printf '%s 없음 — 스캔 없이 통과시키지 않는다\n' "$tool" >&2; exit 2; }
done

# ── 1. history 전체의 path 목록 ──────────────────────────────────────────
# `git rev-list --objects` 를 쓰지 않는다. 같은 내용의 blob 이 여러 path 에 있으면
# 그 blob 을 한 path 이름으로만 출력해서 나머지 이름이 목록에서 조용히 빠진다.
# 이 저장소 실측으로 그렇게 사라지는 경로가 있었다(docs/HISTORY-REDACTION.md).
paths=$(mktemp)
git log --all --name-only -z --pretty=format: | tr '\0' '\n' | sed '/^$/d' | sort -u > "$paths"
printf '[..] history path %s개 검사\n' "$(wc -l < "$paths")"

# 확장자 검사는 대소문자를 가리지 않는다. `x.PDF` 가 통과하는 게이트는 게이트가 아니다.
deny_path() {
	local label=$1 pattern=$2 allow=${3:-} n list
	list=$(grep -iE "$pattern" "$paths" || true)
	if [ -n "$allow" ]; then
		list=$(printf '%s\n' "$list" | grep -vE "$allow" || true)
	fi
	list=$(printf '%s' "$list" | sed '/^$/d')
	n=$(printf '%s' "$list" | grep -c . || true)
	if [ "$n" -gt 0 ]; then
		bad "$label — history 에 $n 개 경로"
		printf '%s\n' "$list" | head -5 >&2
	else
		ok "$label 없음"
	fi
}

deny_path '생성 문서 바이너리(pdf/odt/zip)' '\.(pdf|odt|zip|docx?|xlsx?|hwp)$'
# 도해는 경로 두 개로만 막으면 다음 사람이 다른 폴더에 넣는 순간 다시 샌다. 이미지는
# 확장자로 전역 차단하고, 공개해도 되는 것만 이름으로 연다.
deny_path '이미지 파일'                     '\.(png|jpe?g|gif|svg|webp|bmp|tiff?)$' '^(docs/assets/|README-assets/)'
deny_path '내부 도해 경로'                  '^(dossier|nhn)/images/'
deny_path '받은 과제 원본'                  '/assignment/'
deny_path '로그인 뒤 자동화 코드'           '(^|/)remember\.js$'
deny_path '완성된 지원 폼'                  '(_Detail_Form|_Applicant_Form)\.md$'
deny_path '추천서 원문'                     '(^|/)referral\.md$'
# `pi-…-provider-turn` 뒤에는 날짜가 붙는다. 예전 패턴은 `provider-turn.md` 로 끝나는
# 이름만 잡아서 **실제로 존재했던 유일한 그 경로를 못 잡았다**(mirror 대조로 확인).
# 이름 뒤 꼬리를 허용한다 — 규칙이 실물과 안 맞으면 그건 규칙이 아니라 장식이다.
deny_path '세션 발췌·raw 제3자 복제'        '(provider-turn|-raw)[^/]*\.md$'
deny_path '로컬 상태 스냅샷'                '^\.timeline-|settings\.local\.json$'

# ── 2. commit ident ─────────────────────────────────────────────────────
# 기준은 "옛 주소가 0건"이 아니라 **전수가 noreply** 다. 세지 않은 주소가 남는 것이
# 옛 주소가 남는 것보다 조용하다.
nonnoreply=$(git log --all --format='%ae%n%ce' | grep -vc 'users\.noreply\.github\.com' || true)
if [ "$nonnoreply" -gt 0 ]; then
	bad "commit ident — noreply 가 아닌 필드 $nonnoreply 개"
else
	ok 'commit ident 전수 noreply'
fi

# ── 3. reachable blob 내용 ──────────────────────────────────────────────
# ieee.csl 의 upstream 기여자 이메일은 **지우지 않는다.** 그 파일은 CC-BY-SA-3.0 이고
# 저작자 표시를 벗기면 개인정보 스캔을 통과시키려고 라이선스를 위반하는 셈이 된다.
# 그래서 allowlist 하고 이유를 여기 적는다.
#
# blob 을 한 번만 꺼내 다섯 패턴을 한꺼번에 본다. 범주마다 다시 꺼내면 blob 수 × 범주 수
# 만큼 프로세스를 띄우게 되고, 실측으로 거기서 1분이 갔다.
#
# 🔴 **읽지 못한 blob 을 「없음」으로 세지 않는다.** cat-file 이 실패하면(partial clone,
# 손상, 객체 부재) 예전 구현은 빈 입력으로 무매치가 되어 조용히 통과했다. 실패는 센다.

# git 의 SSH remote 는 `git@host:path` 라 이메일 정규식에 그대로 걸린다. 그건 이메일이
# 아니고, 거의 모든 저장소에 있다. 여기서 걸러 두지 않으면 게이트가 매번 빨간불이 되고
# 그러면 아무도 안 본다. 스캔 직전에만 무해한 표지로 바꾼다 — 파일은 건드리지 않는다.
#
# 앞 경계를 요구한다. 경계 없이 `git@호스트:` 를 지우면 `<사람>@example.com:꼬리` 안의
# `git@example.com:` 꼬리까지 삼켜서 **진짜 이메일이 게이트에서 사라진다.**
# 구분자는 `#` 이다 — 패턴 안에 `|` 와 `/` 가 둘 다 있어서 `s|…|…|` 로는 sed 가 못 읽는다.
# (`s|` 로 쓴 판이 실제로 sed 파싱 오류를 내고 스캔 전체를 건너뛰었다.)
SSH_NEUTRALIZE='s#(^|[^A-Za-z0-9._%+-])((ssh://)?git@[A-Za-z0-9.-]+[:/])#\1<ssh-remote>/#g'

# 스캐너 소스에는 금지 패턴(home/cred)이 정의상 들어 있다. 예전 게이트는 그래서 스캐너
# **파일 두 개를 통째로** 내용 스캔에서 뺐고, 그러면 그 파일에 진짜 이메일을 커밋해도
# 게이트가 초록불이었다(재현 확인). 지금은 **스캐너 경로일 때만** 그 선언/호출 줄을
# 지운다. 다른 경로에는 줄 삭제 규칙을 쓰지 않는다 — 아무 파일에나 `scan '…' ` 접두사를
# 붙여 값을 숨기는 길을 열어 주지 않기 위해서다. 형태도 실측대로 좁힌다 — 줄머리에서
# 시작해 따옴표 리터럴로 끝나는 그 네 줄만이다. 뒤에 무언가 덧붙이면 지워지지 않는다.
neutralize() {
	case "${1:-}" in
	scripts/check-public.sh|scripts/check-public-repo.sh)
		sed -E \
			-e "$SSH_NEUTRALIZE" \
			-e "/^CAT_LABEL\[home\]=.*CAT_PATTERN\[home\]='[^']*'\$/d" \
			-e "/^CAT_LABEL\[cred\]=.*CAT_PATTERN\[cred\]='[^']*'\$/d" \
			-e "/^scan '로컬 절대 홈 경로' '[^']*'\$/d" \
			-e "/^scan '자격증명 패턴' '[^']*'\$/d" \
			-e "/^scan 'private 운영 표식' '[^']*'\$/d"
		;;
	*)
		sed -E -e "$SSH_NEUTRALIZE"
		;;
	esac
}

# 무해화가 스스로를 면제해 주는지 매 실행마다 반증한다. 반증에 실패하면 스캔을 아예
# 돌리지 않는다 — 무해화가 조용히 망가진 게이트는 통과가 아니라 미검사다.
# 픽스처 문자열은 소스에서 쪼개 둔다. 그러지 않으면 게이트가 자기 테스트 데이터를
# 진짜 히트로 잡고, 그걸 면제하려다 다시 자기면제가 생긴다.
_mail='git''@example.com'
_embedded='legit''@example.com:descriptive-suffix'
_ssh='git''@example.com:owner/repo.git'
_selfline="CAT_LABEL[home]='x'; CAT_PATTERN[home]='/""home/[^/[:space:]]+/'"
_selftest_fail() { printf 'neutralize self-test 실패 — %s\n' "$1" >&2; exit 2; }

_n=$(printf '%s\n' "$_mail" "$_embedded" "$_ssh" | neutralize other/ordinary-file.md)
if ! printf '%s\n' "$_n" | grep -Fxq "$_mail"; then
	_selftest_fail '평범한 이메일을 삼킨다'
fi
if ! printf '%s\n' "$_n" | grep -Fxq "$_embedded"; then
	_selftest_fail '긴 local-part 안의 git@ 꼬리를 삼킨다'
fi
if printf '%s\n' "$_n" | grep -Fq "$_ssh"; then
	_selftest_fail 'SSH remote 를 무해화하지 못했다'
fi
if ! printf '%s\n' "$_selfline" | neutralize other/ordinary-file.md | grep -q .; then
	_selftest_fail '스캐너가 아닌 파일에서도 줄을 지운다'
fi
if printf '%s\n' "$_selfline" | neutralize scripts/check-public-repo.sh | grep -q .; then
	_selftest_fail '스캐너 자신의 패턴 선언 줄이 남는다'
fi
unset _mail _embedded _ssh _selfline _n

objects=$(mktemp); blobs=$(mktemp); body=$(mktemp)
trap 'rm -f "$paths" "$objects" "$objects.pairs" "$objects.first" "$blobs" "$body" "$body.n"' EXIT

# 프로세스 치환 대신 파일로 받는다 — rev-list 가 실패하면 빈 루프가 되어 "없음"으로
# 읽히는 자리였다. 여기서는 실패가 곧 게이트 실패다.
git rev-list --objects --all > "$objects" || { bad 'rev-list 실패 — 미검사'; exit 1; }
awk 'NF>1 {print $1"\t"substr($0, index($0,$2))}' "$objects" > "$objects.pairs"
cut -f1 "$objects.pairs" | git cat-file --batch-check='%(objectname) %(objecttype)' 2>/dev/null \
	| awk '$2=="blob"{print $1}' | sort -u > "$blobs"
blob_total=$(wc -l < "$blobs")
printf '[..] reachable blob %s개 검사\n' "$blob_total"

declare -A CAT_LABEL CAT_PATTERN CAT_ALLOW
CAT_LABEL[email]='이메일 주소';        CAT_PATTERN[email]='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'; CAT_ALLOW[email]='templates/ieee\.csl$'
CAT_LABEL[phone]='한국 휴대폰 형식';   CAT_PATTERN[phone]='01[016789][ .-]?[0-9]{3,4}[ .-]?[0-9]{4}'
CAT_LABEL[home]='로컬 절대 홈 경로';   CAT_PATTERN[home]='/home/[^/[:space:]]+/'
CAT_LABEL[uuid]='candidate UUID';      CAT_PATTERN[uuid]='[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}'
CAT_LABEL[cred]='자격증명 패턴';       CAT_PATTERN[cred]='(sk-[A-Za-z0-9_-]{16,}|ghp_[A-Za-z0-9]{20,}|github_pat_|AKIA[0-9A-Z]{16}|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY)'
CATS='email phone home uuid cred'

declare -A HITS
for c in $CATS; do HITS[$c]=0; done
unreadable=0

# blob 하나당 경로 하나만 알면 된다(보고용). 같은 blob 이 여러 경로에 있으면 첫 경로를 쓴다.
awk -F'\t' '!seen[$1]++ {print $1"\t"$2}' "$objects.pairs" > "$objects.first"

while IFS=$'\t' read -r oid path; do
	grep -qx "$oid" "$blobs" || continue
	if ! git cat-file blob "$oid" > "$body" 2>/dev/null; then
		unreadable=$((unreadable+1))
		printf '        읽지 못함: %s\n' "$path" >&2
		continue
	fi
	neutralize "$path" < "$body" > "$body.n"
	for c in $CATS; do
		allow=${CAT_ALLOW[$c]:-}
		if [ -n "$allow" ] && printf '%s' "$path" | grep -qE "$allow"; then continue; fi
		if rg -q -e "${CAT_PATTERN[$c]}" "$body.n"; then
			HITS[$c]=$(( ${HITS[$c]} + 1 ))
			printf '        [%s] %s\n' "$c" "$path" >&2
		fi
	done
done < "$objects.first"

for c in $CATS; do
	if [ "${HITS[$c]}" -gt 0 ]; then
		bad "${CAT_LABEL[$c]} — blob ${HITS[$c]} 개 (경로만 표시, 값은 표시하지 않는다)"
	else
		ok "${CAT_LABEL[$c]} 없음"
	fi
done

if [ "$unreadable" -gt 0 ]; then
	bad "읽지 못한 blob $unreadable 개 — 「없음」이 아니라 미검사다"
else
	ok "모든 reachable blob 을 읽었다"
fi

# ── 3b. commit message 본문 ─────────────────────────────────────────────
# blob 만 보면 절반이다. 정제 표현은 커밋 메시지에도 적용했고(docs/HISTORY-REDACTION.md),
# **적용했다는 주장은 검사로 받쳐야 한다.** 예전에는 여기에 검사가 아예 없어서, 메시지에
# 남은 값은 게이트가 초록불인 채로 지나갔다.
#
# 신원 필드는 위에서 이미 전수 noreply 로 봤다. 메시지 안의 noreply 주소는 봇
# `Co-authored-by:` 트레일러이고 같은 기준으로 이미 통과한 값이라 여기서 덜어 낸다.
msgs=$(mktemp)
if ! git log --all --format='%B' | neutralize commit-message \
	| sed -E 's#[A-Za-z0-9._%+-]+@users\.noreply\.github\.com#<noreply>#g' > "$msgs"; then
	bad '커밋 메시지를 읽지 못했다 — 미검사이므로 통과로 보지 않는다'
else
	for c in $CATS; do
		if rg -q -e "${CAT_PATTERN[$c]}" "$msgs"; then
			bad "${CAT_LABEL[$c]} — 커밋 메시지 (값은 표시하지 않는다)"
		else
			ok "${CAT_LABEL[$c]} 없음 — 커밋 메시지"
		fi
	done
fi
rm -f "$msgs"

# ── 4. 외부 스캐너 ──────────────────────────────────────────────────────
# 미설치는 "0건"이 아니라 실패다. --redact 로 값을 로그에 남기지 않는다.
if command -v gitleaks >/dev/null; then
	if gitleaks git --redact --no-banner "$repo" >/dev/null 2>&1; then ok 'gitleaks'
	else bad 'gitleaks — 후보 존재 (로컬 private report 로 확인)'; fi
else
	bad 'gitleaks 미설치 — 미검사이므로 통과로 보지 않는다'
fi

# `--fail` 은 verified 가 하나라도 있으면 비0으로 끝난다. unverified 는 실패로 보지 않되
# 건수를 보여 준다 — 이 저장소의 알려진 unverified 1건은 GLG 본인의 공개 프로필 슬러그를
# GitLab 토큰으로 오인한 것이고, 그 판정은 사람이 한 번 내려서 여기 적어 둔 것이다.
# trufflehog 출력에는 후보 값이 그대로 실리므로 stdout 을 게이트 로그로 흘리지 않는다.
if command -v trufflehog >/dev/null; then
	th_err=$(mktemp)
	trufflehog git "file://$repo" --results=verified --fail >/dev/null 2>"$th_err"
	th_status=$?
	# exit 이 0 이 아니라고 전부 "발견"이 아니다. 플래그 오류·크래시·객체 결손도 비0 이다.
	# 셋을 같은 문장으로 보고하면 진단이 엉뚱한 곳을 가리킨다 — 통과가 아닌 건 같지만.
	case $th_status in
		0) ok 'trufflehog — verified secret 0' ;;
		183) bad 'trufflehog — verified secret 발견 (로컬 private report 로 확인)' ;;
		*)
			bad "trufflehog 실행 실패 (exit $th_status) — 미검사이므로 통과로 보지 않는다"
			head -3 "$th_err" >&2
			;;
	esac
	rm -f "$th_err"
else
	bad 'trufflehog 미설치 — 미검사이므로 통과로 보지 않는다'
fi

# ── 5. 공개 계약 문서 ───────────────────────────────────────────────────
for f in LICENSE LICENSING.md NOTICE.md docs/HISTORY-REDACTION.md; do
	[ -f "$repo/$f" ] && ok "$f 존재" || bad "$f 없음 — 공개 계약 문서가 빠졌다"
done

if [ "$fail" -ne 0 ]; then
	printf '\n공개 게이트 실패. 값은 여기 찍지 않는다 — 로컬 private report 를 본다.\n' >&2
	exit 1
fi
printf '\n공개 게이트 통과. 아직 사람의 전 파일 검토가 남았다.\n'
