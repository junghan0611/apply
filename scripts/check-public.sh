#!/usr/bin/env bash
# check-public.sh — clean public export의 구조·누출을 보수적으로 검사한다.
#
#   ./scripts/check-public.sh /path/to/public-export
#
# 현재 private checkout에 돌리는 도구가 아니다. PUBLICATION.md allowlist로 만든 새 트리에
# 돌린다. 통과는 공개 승인과 같지 않다 — 마지막에는 사람이 모든 파일을 읽는다.
set -euo pipefail

root=${1:-}
if [ -z "$root" ] || [ ! -d "$root" ]; then
	printf 'usage: %s /path/to/public-export\n' "$0" >&2
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

# rg 종료 코드: 0=매치, 1=매치 없음, 2 이상=오류. 오류를 "없음"으로 읽지 않는다.
scan() {
	local label=$1 pattern=$2 hits status
	hits=$(mktemp)
	set +e
	rg -n -I --hidden --glob '!.git/**' --glob '!**/scripts/check-public.sh' \
		-e "$pattern" "$root" >"$hits" 2>"$hits.err"
	status=$?
	set -e
	case $status in
		0)
			bad "$label"
			head -20 "$hits" >&2
			;;
		1) ok "$label 없음" ;;
		*)
			bad "$label — 스캔 실패(rg exit $status). 미검사이므로 통과로 보지 않는다"
			head -5 "$hits.err" >&2
			;;
	esac
	rm -f "$hits" "$hits.err"
}

scan '로컬 절대 홈 경로' '/home/[^/[:space:]]+'
scan '이메일 주소' '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
scan '한국 휴대폰 형식' '01[016789][ -]?[0-9]{3,4}[ -]?[0-9]{4}'
scan '자격증명 패턴' '(sk-[A-Za-z0-9_-]{16,}|ghp_[A-Za-z0-9]{20,}|github_pat_|AKIA[0-9A-Z]{16}|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY)'
scan 'private 운영 표식' '(생년월일|병역사항|현재 연봉|추천 경로|개인정보 동의)'

if [ -x "$root/.claude/skills/linkedin-jobs/test_ljobs.py" ]; then
	if (cd "$root" && PYTHONDONTWRITEBYTECODE=1 .claude/skills/linkedin-jobs/test_ljobs.py); then
		ok 'linkedin-jobs 회귀 검사'
	else
		bad 'linkedin-jobs 회귀 검사 실패'
	fi
fi

if [ "$fail" -ne 0 ]; then
	printf '\n공개 게이트 실패. PUBLICATION.md allowlist와 수동 검토를 다시 확인한다.\n' >&2
	exit 1
fi
printf '\n공개 게이트 통과. 아직 사람의 전 파일 검토와 라이선스 결정이 남았다.\n'
