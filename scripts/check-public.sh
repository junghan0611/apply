#!/usr/bin/env bash
# check-public.sh — clean public export의 구조·누출을 보수적으로 검사한다.
#
#   ./scripts/check-public.sh /path/to/public-export
#
# 현재 private checkout에 돌리는 도구가 아니다. PUBLICATION.md allowlist로 만든 새 트리에
# 돌린다. 통과는 공개 승인과 같지 않다 — 마지막에는 사람이 모든 파일을 읽는다.
set -euo pipefail

# 두 가지 모드가 있다.
#
#   ./scripts/check-public.sh /path/to/public-export   # (구) allowlist export 트리 검사
#   ./scripts/check-public.sh --repo [<repo>]          # (현) 공개 저장소 자체 검사
#
# 지금의 공개 전략은 allowlist 로 새 트리를 뜨는 것이 아니라 **전체 history 를 정제해서
# 그대로 싣는 것**이다(PUBLICATION.md). 그래서 현재 트리만 보는 검사로는 부족하다 —
# `--repo` 는 reachable blob · path · commit metadata 까지 본다.
#
# 게이트는 **탐지된 원문 값을 출력하지 않는다.** path 와 범주만 보인다. 값을 CI 로그에
# 찍으면 게이트가 누출면이 된다.
if [ "${1:-}" = "--repo" ]; then
	repo=${2:-.}
	exec "$(dirname "$0")/check-public-repo.sh" "$repo"
fi

root=${1:-}
if [ -z "$root" ] || [ ! -d "$root" ]; then
	printf 'usage: %s /path/to/public-export\n' "$0" >&2
	printf '       %s --repo [<repo>]\n' "$0" >&2
	exit 2
fi
root=$(cd "$root" && pwd)
fail=0

ok() { printf '[OK] %s\n' "$*"; }
bad() { printf '[ERROR] %s\n' "$*" >&2; fail=1; }

# 스캔 도구가 없으면 모든 검사가 조용히 "없음"으로 통과한다. 공개 게이트에서 그건
# 통과가 아니라 미검사다. 먼저 막는다.
command -v rg >/dev/null || {
	printf 'ripgrep(rg)이 없다. 스캔 없이 통과시키지 않는다.\n' >&2
	exit 2
}

# 공개 트리는 private object database를 물려받지 않는다.
if [ -e "$root/.git" ]; then
	bad '.git/ 존재 — private history를 복사하지 말고 검사 뒤 새 history를 만든다'
else
	ok '.git/ 없음'
fi

for path in applications dossier NEXT.md .timeline-events.jsonl .timeline-snapshot.json \
            .timeline-manifest.json .claude/settings.local.json; do
	if [ -e "$root/$path" ]; then
		bad "금지 경로 포함: $path"
	fi
done

if find "$root" -type f \( -iname '*.pdf' -o -iname '*.zip' -o -iname '*.odt' \
     -o -iname '*.doc' -o -iname '*.docx' \) -print -quit | grep -q .; then
	bad '문서/아카이브 파생물 포함 — 초기 공개 allowlist에는 넣지 않는다'
else
	ok '문서/아카이브 파생물 없음'
fi

if find "$root" -type d \( -name __pycache__ -o -name node_modules -o -name build \) \
     -print -quit | grep -q .; then
	bad '캐시/의존성/build 디렉터리 포함'
else
	ok '캐시/의존성/build 디렉터리 없음'
fi

# 스캐너 소스에는 금지 패턴(home/cred)이 정의상 들어 있다. 예전에는 이 파일을 통째로
# 스캔에서 뺐고(`--glob '!**/scripts/check-public.sh'`), 그러면 이 파일 안에 진짜 이메일을
# 넣어도 게이트가 초록불이었다(재현 확인). 이제 파일을 통째로 빼지 않는다 —
# **스캐너 경로일 때만** 그 선언/호출 줄을 지우고, 나머지 줄은 전부 검사한다.
# 구분자는 `#` 이다 — 패턴 안에 `|` 와 `/` 가 둘 다 있어서 `s|…|…|` 로는 sed 가 못 읽는다.
SSH_NEUTRALIZE='s#(^|[^A-Za-z0-9._%+-])((ssh://)?git@[A-Za-z0-9.-]+[:/])#\1<ssh-remote>/#g'

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

# 무해화가 스스로를 면제해 주는지 매 실행마다 반증한다. 픽스처는 소스에서 쪼개 둔다.
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
if printf '%s\n' "$_selfline" | neutralize scripts/check-public.sh | grep -q .; then
	_selftest_fail '스캐너 자신의 패턴 선언 줄이 남는다'
fi
unset _mail _embedded _ssh _selfline _n

# rg 종료 코드: 0=매치, 1=매치 없음, 2 이상=오류. 오류를 "없음"으로 읽지 않는다.
#
# 두 단계다. `rg -l` 로 후보 파일을 뽑고, 그 파일을 무해화해 **다시** 패턴에 거는 줄이
# 남는지 본다. 남으면 진짜 히트다. 파일 이름을 `:` 로 쪼개 파싱하지 않는다 — 경로에 `:`
# 가 있으면 조용히 틀린다.
#
# 히트의 **값은 찍지 않는다.** 이 파일 머리말의 계약이 그렇다(경로와 범주만). 값을
# 게이트 로그에 흘리면 게이트 자체가 누출면이 된다.
scan() {
	local label=$1 pattern=$2 cand hits err status n rel
	cand=$(mktemp); hits=$(mktemp); err=$(mktemp)
	set +e
	rg -l --hidden --glob '!.git/**' -e "$pattern" "$root" >"$cand" 2>"$err"
	status=$?
	set -e
	if [ "$status" -gt 1 ]; then
		bad "$label — 스캔 실패(rg exit $status). 미검사이므로 통과로 보지 않는다"
		head -5 "$err" >&2
		rm -f "$cand" "$hits" "$err"
		return
	fi
	: > "$hits"
	while IFS= read -r f; do
		[ -n "$f" ] || continue
		rel=${f#"$root"/}
		if neutralize "$rel" < "$f" | rg -q -e "$pattern"; then
			printf '%s\n' "$rel" >> "$hits"
		fi
	done < "$cand"
	n=$(sort -u "$hits" | grep -c . || true)
	if [ "$n" -gt 0 ]; then
		bad "$label — 파일 $n 개 (경로만 표시, 값은 표시하지 않는다)"
		sort -u "$hits" | head -10 >&2
	else
		ok "$label 없음"
	fi
	rm -f "$cand" "$hits" "$err"
}

scan '로컬 절대 홈 경로' '/home/[^/[:space:]]+'
scan '이메일 주소' '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
scan '한국 휴대폰 형식' '01[016789][ -]?[0-9]{3,4}[ -]?[0-9]{4}'
scan '자격증명 패턴' '(sk-[A-Za-z0-9_-]{16,}|ghp_[A-Za-z0-9]{20,}|github_pat_|AKIA[0-9A-Z]{16}|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY)'
scan 'private 운영 표식' '(생년월일|병역사항|현재 연봉|추천 경로|개인정보 동의)'

# 실행 비트가 없다고 조용히 건너뛰면 「검사했는데 통과」와 「검사 자체를 안 함」이 같은
# 화면이 된다. 파일이 있으면 인터프리터로라도 돌리고, 아예 없으면 없다고 말한다.
if [ -f "$root/.claude/skills/linkedin-jobs/test_ljobs.py" ]; then
	if (cd "$root" && PYTHONDONTWRITEBYTECODE=1 python3 .claude/skills/linkedin-jobs/test_ljobs.py); then
		ok 'linkedin-jobs 회귀 검사'
	else
		bad 'linkedin-jobs 회귀 검사 실패'
	fi
else
	bad 'linkedin-jobs 회귀 검사 파일 없음 — 미검사이므로 통과로 보지 않는다'
fi

if [ "$fail" -ne 0 ]; then
	printf '\n공개 게이트 실패. PUBLICATION.md allowlist와 수동 검토를 다시 확인한다.\n' >&2
	exit 1
fi
printf '\n공개 게이트 통과. 아직 사람의 전 파일 검토와 라이선스 결정이 남았다.\n'
