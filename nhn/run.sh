#!/usr/bin/env bash
# NHN AX 제출문서 — Org SSOT → ODT → PDF / Markdown 빌드
#
# 이 저장소(~/repos/gh/apply/nhn)는 private이다. 제출본은 채용사에 직접 업로드하므로
# 고객사·사내 사실을 담을 수 있다. 공개면(ax.junghanacs.com)과는 별개 트랙.
#
# 파이프라인:
#   competency.org / portfolio.org → proposal-export.el(org→odt) → odt_postprocess.py
#       (border/header shading, 캡션 번호 유지) → libreoffice(odt→pdf)
#   detail.org → pandoc(org→gfm)
#
# 도구 출처: emacs·libreoffice 는 호스트 전역(NixOS). pandoc·pdftotext·pdfinfo 는
#   호스트 PATH에 없어 ax flake devshell 경유(AXRUN). 최종 검수 로그에 이 의존성을 명시.
#
# 사용법:
#   ./run.sh check         # 의존성 점검
#   ./run.sh competency    # ① 역량·성과 기술서 PDF
#   ./run.sh portfolio     # ② 포트폴리오 PDF
#   ./run.sh detail        # ③ 상세 Markdown
#   ./run.sh all           # 3종 전부
#   ./run.sh verify        # 산출물 검수 (페이지수·캡션·:noexport 누출·연락처)
#   ./run.sh clean         # 중간산물 정리
#   ./run.sh package       # 상세 MD·Org·이미지·Bib·파이프라인을 ZIP으로 조립
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PIPE="$DIR/pipeline"
EXPORT_EL="$PIPE/proposal-export.el"
BUILD="$DIR/build"
STAGE=".package/KimJunghan_AX_Evidence_Package"
# poppler(pdftotext·pdfinfo)·pandoc 해결 순서 — 이 순서 덕에 패키지된 run.sh 가 절대경로 없이도 돈다:
#   (1) PATH 에 있으면 그대로  (2) 로컬 AX flake 가 있으면 경유  (3) 둘 다 없으면 필요한 패키지를 안내.
# AX_FLAKE 기본값은 package 조립 시 비워져 배포본에 절대경로가 남지 않는다.
AX_FLAKE="${AX_FLAKE:-~/repos/gh/junghan0611/apply/ax}"

# 부트스트랩: straight build 있는 코어를 EMACSDIR로. proposal-export.el 이 스스로 탐지도
# 하지만 결정성을 위해 여기서 고정한다(호스트 daemon 코어 = ~/.emacs.d → doomemacs).
export EMACSDIR="${EMACSDIR:-~/doomemacs}"
export DOOMDIR="${DOOMDIR:-~/repos/gh/doomemacs-config}"

GREEN='\033[0;32m'; RED='\033[0;31m'; BLUE='\033[0;34m'; YELLOW='\033[1;33m'; NC='\033[0m'
info() { echo -e "${BLUE}[INFO]${NC} $*"; }
ok()   { echo -e "${GREEN}[OK]${NC} $*"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*"; }
err()  { echo -e "${RED}[ERROR]${NC} $*" >&2; }

# pandoc / pdftotext / pdfinfo — PATH 우선, 없으면 AX flake, 그것도 없으면 안내
AXRUN() {
  local tool="$1"
  if command -v "$tool" >/dev/null 2>&1; then "$@"
  elif [ -n "$AX_FLAKE" ] && [ -d "$AX_FLAKE" ]; then ( cd "$AX_FLAKE" && nix develop -c "$@" )
  else err "'$tool' 없음 — poppler-utils(pdftotext·pdfinfo)와 pandoc 를 설치하거나 AX_FLAKE 에 nix flake 경로를 지정하세요."; return 127
  fi
}

declare -A FINAL=(
  [competency]="KimJunghan_AX_Competency"
  [portfolio]="KimJunghan_AX_Portfolio"
)

cmd_check() {
  command -v emacs       >/dev/null && ok "emacs: $(emacs --version | head -1)" || { err "emacs 없음"; exit 1; }
  command -v libreoffice >/dev/null && ok "libreoffice 있음"                     || { err "libreoffice 없음"; exit 1; }
  command -v python3     >/dev/null && ok "python3: $(python3 --version)"        || { err "python3 없음"; exit 1; }
  [[ -f "$EXPORT_EL" ]] && ok "proposal-export.el 있음"                          || { err "$EXPORT_EL 없음"; exit 1; }
  [[ -f "$PIPE/templates/reference.odt" ]] && ok "reference.odt 있음"            || { err "reference.odt 없음"; exit 1; }
  [[ -f "$PIPE/templates/ieee.csl" ]] && ok "ieee.csl 있음"                      || { err "ieee.csl 없음"; exit 1; }
  [[ -f "$DIR/references.bib" ]] && ok "references.bib 있음"                     || { err "references.bib 없음"; exit 1; }
  [[ -d "$EMACSDIR/.local/straight" ]] && ok "Doom core: $EMACSDIR"             || { err "straight build 없음: $EMACSDIR"; exit 1; }
  info "ax flake 경유 도구 점검(pandoc/pdftotext)…"
  AXRUN pandoc --version >/dev/null 2>&1 && ok "pandoc (ax flake)"              || warn "pandoc 확인 실패"
  AXRUN pdftotext -v      >/dev/null 2>&1 && ok "pdftotext/pdfinfo (ax flake)"  || warn "poppler 확인 실패"
}

# org → odt → postprocess → pdf, build/<FINAL>.pdf 로.
build_pdf() {
  local key="$1" org="$DIR/$1.org" base="${FINAL[$1]}"
  [[ -f "$org" ]] || { err "$org 없음"; exit 1; }
  mkdir -p "$BUILD"
  info "[$key] org → odt (emacs org-odt-export)"
  emacs --batch -l "$EXPORT_EL" \
    --eval "(proposal-export-to-odt (expand-file-name \"$org\"))" 2>&1 \
    | grep -E "SUCCESS|ERROR|Cannot open|Warning \(citeproc\)" || true
  local odt="$DIR/$1.odt"
  [[ -f "$odt" ]] || { err "[$key] ODT 생성 실패"; exit 1; }
  info "[$key] odt 후처리 (border/header shading, 캡션 번호 유지)"
  python3 "$PIPE/odt_postprocess.py" "$odt"
  info "[$key] odt → pdf (libreoffice headless)"
  libreoffice -env:UserInstallation="file:///tmp/lo_submission_$1" \
    --headless --convert-to pdf "$odt" --outdir "$DIR" >/dev/null 2>&1
  local pdf="$DIR/$1.pdf"
  [[ -f "$pdf" ]] || { err "[$key] PDF 생성 실패"; exit 1; }
  mv -f "$odt" "$BUILD/$base.odt"
  mv -f "$pdf" "$BUILD/$base.pdf"
  local pages; pages="$(AXRUN pdfinfo "$BUILD/$base.pdf" 2>/dev/null | awk '/^Pages/{print $2}')"
  ok "[$key] $BUILD/$base.pdf — ${pages}p, $(du -h "$BUILD/$base.pdf" | cut -f1)"
}

cmd_detail() {
  local org="$DIR/detail.org"
  [[ -f "$org" ]] || { err "$org 없음"; exit 1; }
  mkdir -p "$BUILD"
  info "[detail] org → gfm (pandoc, ax flake)"
  AXRUN pandoc "$org" -f org -t gfm --wrap=none --toc \
    --citeproc --bibliography="$DIR/references.bib" \
    --csl="$PIPE/templates/ieee.csl" \
    -o "$BUILD/KimJunghan_AX_Detail.md"
  ok "[detail] $BUILD/KimJunghan_AX_Detail.md — $(wc -l < "$BUILD/KimJunghan_AX_Detail.md") lines, $(du -h "$BUILD/KimJunghan_AX_Detail.md" | cut -f1)"
}

# 산출물 검수 — 페이지수, 캡션 번호, :noexport 누출, 연락처/URL.
cmd_verify() {
  local fail=0
  for key in competency portfolio; do
    local base="${FINAL[$key]}" pdf="$BUILD/${FINAL[$key]}.pdf"
    [[ -f "$pdf" ]] || { warn "$pdf 없음 (아직 빌드 안 함)"; continue; }
    local txt; txt="$(AXRUN pdftotext "$pdf" - 2>/dev/null)"
    local pages; pages="$(AXRUN pdfinfo "$pdf" 2>/dev/null | awk '/^Pages/{print $2}')"
    echo "── $base.pdf (${pages}p) ──"
    # 별표 누출 (Org 굵게가 렌더 안 되고 별표로 샌 경우)
    if echo "$txt" | grep -q '[*]'; then warn "  별표(*) 누출 — 굵게 렌더 실패 의심"; fail=1; else ok "  별표 누출 없음"; fi
    # :noexport 프롬프트/메모 누출
    if echo "$txt" | grep -qiE 'noexport|생성 프롬프트|IMAGE PROMPT|TODO|검토 메모'; then warn "  :noexport 내용 누출 의심"; fail=1; else ok "  :noexport 누출 없음"; fi
    # 연락처 + 대표 URL
    echo "$txt" | grep -q '[email removed]' && ok "  이메일 노출" || { warn "  이메일 안 보임"; fail=1; }
    echo "$txt" | grep -q 'github.com/junghan0611' && ok "  GitHub URL 노출" || { warn "  GitHub URL 안 보임"; fail=1; }
    # 캡션 번호
    echo "$txt" | grep -qE '표 [0-9]|그림 [0-9]' && ok "  캡션 연번(표/그림 N) 존재" || warn "  캡션 연번 없음(이미지/표 미포함이면 정상)"
  done
  local md="$BUILD/KimJunghan_AX_Detail.md"
  if [[ -f "$md" ]]; then
    echo "── KimJunghan_AX_Detail.md ──"
    grep -qiE 'noexport|IMAGE PROMPT' "$md" && { warn "  :noexport 누출 의심"; fail=1; } || ok "  :noexport 누출 없음"
    grep -q 'github.com/junghan0611' "$md" && ok "  자체 프로젝트 공개 링크 존재" || warn "  공개 링크 없음"
  fi
  [[ $fail -eq 0 ]] && ok "verify 통과" || { err "verify 경고 있음 — 위 항목 확인"; return 1; }
}

cmd_clean() {
  rm -f "$DIR"/*.odt "$DIR"/*.pdf
  rm -rf "$DIR"/_smoke
  ok "중간산물 정리 (build/ 최종본은 유지)"
}

# 증거 패키지 ZIP — allowlist 스테이징 → zip + MANIFEST.sha256.
# 넣지 않는 것: .git · _smoke · *.odt · *.log · 편집기 잠금 · 원본 PRIVATE.md · 로컬 절대경로.
cmd_package() {
  local COMP="$BUILD/KimJunghan_AX_Competency.pdf" PORT="$BUILD/KimJunghan_AX_Portfolio.pdf" MD="$BUILD/KimJunghan_AX_Detail.md"
  for f in "$COMP" "$PORT" "$MD"; do [[ -f "$f" ]] || { err "$f 없음 — 먼저 ./run.sh all"; exit 1; }; done
  local S="$DIR/$STAGE"
  rm -rf "$DIR/.package"; mkdir -p "$S"/{sources,images,pipeline/templates,outputs}
  # allowlist 복사
  cp "$DIR/README.package.md" "$S/README.md"
  cp "$DIR/AGENTS.md"          "$S/AGENTS.md"
  cp "$MD"                     "$S/KimJunghan_AX_Detail.md"
  cp "$DIR/competency.org" "$DIR/portfolio.org" "$DIR/detail.org" "$S/sources/"
  local image_count=0
  while IFS= read -r -d '' image; do
    cp "$image" "$S/images/"
    image_count=$((image_count + 1))
  done < <(find "$DIR/images" -maxdepth 1 -type f \
    \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) -print0)
  [[ $image_count -gt 0 ]] || warn "images/ 비어있음 (이미지 생성 전)"
  cp "$DIR/references.bib" "$S/"
  cp "$DIR/run.sh"         "$S/run.sh"
  cp "$PIPE/proposal-export.el" "$PIPE/odt_postprocess.py" "$S/pipeline/"
  cp "$PIPE/templates/ieee.csl" "$PIPE/templates/reference.odt" "$S/pipeline/templates/"
  cp "$COMP" "$PORT" "$S/outputs/"
  # 배포본 run.sh 에서 로컬 절대경로 기본값 제거 (PATH/사용자 지정으로 동작)
  sed -i -E 's#(AX_FLAKE=")\$\{AX_FLAKE:-[^}]*\}(")#\1${AX_FLAKE:-}\2#; s#(EMACSDIR=")\$\{EMACSDIR:-[^}]*\}(")#\1${EMACSDIR:-}\2#; s#(DOOMDIR=")\$\{DOOMDIR:-[^}]*\}(")#\1${DOOMDIR:-}\2#' "$S/run.sh"
  # MANIFEST.sha256 (재현 가능한 정렬)
  ( cd "$S" && find . -type f ! -name MANIFEST.sha256 | LC_ALL=C sort | xargs sha256sum > MANIFEST.sha256 )
  # 절대경로 누출 검사 — PM 지정 대상(README·AGENTS·MD·MANIFEST·run.sh). 홈 경로 리터럴을
  # 소스에 두지 않으려 $HOME 로 검색한다(패키지된 run.sh 자신에 절대경로가 안 남게).
  info "절대경로(사용자 홈) 누출 검사…"
  local leak; leak=$(grep -rIl "$HOME" "$S/README.md" "$S/AGENTS.md" "$S/KimJunghan_AX_Detail.md" "$S/MANIFEST.sha256" "$S/run.sh" 2>/dev/null || true)
  [[ -z "$leak" ]] && ok "핵심 파일에 절대경로 누출 없음" || { warn "절대경로 발견:"; echo "$leak"; }
  # zip
  local zip="$BUILD/KimJunghan_AX_Evidence_Package.zip"
  rm -f "$zip"; ( cd "$DIR/.package" && zip -qr "$zip" KimJunghan_AX_Evidence_Package -x '*.DS_Store' )
  ok "ZIP: $zip ($(du -h "$zip" | cut -f1))"
  info "ZIP 내용:"; ( cd "$S" && find . -type f | LC_ALL=C sort | sed 's#^\./#    #' )
}

cd "$DIR"
case "${1:-all}" in
  check)      cmd_check ;;
  competency) build_pdf competency ;;
  portfolio)  build_pdf portfolio ;;
  detail)     cmd_detail ;;
  all)        build_pdf competency; build_pdf portfolio; cmd_detail; cmd_verify ;;
  verify)     cmd_verify ;;
  package)    cmd_package ;;
  clean)      cmd_clean ;;
  *) echo "사용법: ./run.sh {check|competency|portfolio|detail|all|verify|package|clean}"; exit 1 ;;
esac
