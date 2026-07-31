#!/usr/bin/env bash
# NHN AX 제출문서 — Org SSOT → ODT → PDF / Markdown 빌드
#
# 이 저장소(~/repos/gh/apply/nhn)는 private이다. 제출본은 채용사에 직접 업로드하므로
# 고객사·사내 사실을 담을 수 있다. 공개면(ax.junghanacs.com)과는 별개 트랙.
#
# 파이프라인 — 하나의 Org 정본이 두 표면으로 갈라진다:
#
#   competency.org ┬→ latex-export.el(org→tex) → xelatex ─────────→ .pdf  제출 정본
#   portfolio.org  │      acmart manuscript · A4 1단 · 한글 xetexko
#                  └→ proposal-export.el(org→odt) → odt_postprocess.py
#                         → .odt → libreoffice → .doc → (한글에서 HWP 저장)
#   competency.org ┐
#   portfolio.org  ├→ pandoc(org→gfm) → machine-readable .md 3종
#   detail.org     ┘
#   images/master   → optimize_images.py → images/   (생성 원본은 보존)
#
# 두 표면은 경쟁하지 않는다. PDF 는 조판 품질을, ODT/DOC 는 받는 쪽이 열어서 고칠 수
# 있는 편집면을 맡는다. 같은 정본에서 갈라지므로 내용이 어긋날 자리가 없다.
#
# 도구 출처: emacs·libreoffice 는 호스트 전역(NixOS). 조판(texlive·acmart·xetexko)과
#   활자(Pretendard·D2Coding)는 이 디렉터리의 flake devshell 이 쥔다(NIXRUN) — 호스트
#   texlive 는 scheme-medium 이라 acmart 가 없고, 활자가 다르면 같은 소스에서 다른
#   문서가 나온다. pandoc·poppler 는 PATH 우선, 없으면 ax flake 경유(AXRUN).
#
# 사용법:
#   ./run.sh check         # 의존성 점검
#   ./run.sh competency    # ① 역량·성과 기술서 (PDF + ODT/DOC)
#   ./run.sh portfolio     # ② 포트폴리오 (PDF + ODT/DOC)
#   ./run.sh detail        # ③ competency·portfolio·detail Markdown 3종
#   ./run.sh images        # ④ 생성 원본 → 문서용 축소본
#   ./run.sh all           # ①②③ 전부 + 검수
#   ./run.sh verify        # 산출물 검수 (별표 누출·:noexport 누출·연락처·캡션)
#   ./run.sh clean         # 중간산물 정리
#   ./run.sh package       # 소스·산출물·파이프라인·flake 를 ZIP 으로 조립
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

# 조판 도구는 PATH 로 대체하지 않는다. AXRUN 과 달리 "있으면 그걸 쓴다" 가 아니라
# 언제나 flake devshell 을 경유한다 — 호스트 texlive 는 scheme-medium 이라 acmart 가
# 없고, 무엇보다 활자가 다르면 같은 소스에서 다른 문서가 나오기 때문이다. 호스트
# 폰트 캐시를 상속하지 않게 flake 가 FONTCONFIG_FILE 을 고정한다.
NIXRUN() {
  command -v nix >/dev/null 2>&1 || {
    err "nix 없음 — PDF 조판은 flake devshell(acmart·xetexko·Pretendard)이 필요합니다."; return 127; }
  ( cd "$DIR" && nix develop --command "$@" )
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
  # 스타일 마스터가 본문을 들고 있지 않은지 본다. reference.odt 는 한글 제안서를 저장해
  # 만든 것이라 한때 그 제안서 전체(본문 10만 자·이미지 48장·9MB)를 담고 있었다. ox-odt 는
  # styles.xml 만 꺼내므로 산출물은 멀쩡했고, 그래서 아무도 눈치채지 못한 채 그 문서가
  # package ZIP 에 실려 나갔다. 용량이 아니라 유출이라, 조용히 되살아나면 안 되는 종류다.
  local ref_body; ref_body="$(python3 - "$PIPE/templates/reference.odt" <<'PY'
import re, sys, zipfile
with zipfile.ZipFile(sys.argv[1]) as z:
    body = z.read("content.xml").decode("utf-8", "replace") if "content.xml" in z.namelist() else ""
    images = sum(1 for n in z.namelist() if n.lower().startswith(("images/", "pictures/")))
print(len(re.sub(r"\s+", "", re.sub(r"<[^>]+>", "", body))) + images * 1000)
PY
)"
  [[ "$ref_body" -eq 0 ]] && ok "reference.odt 스타일 전용 (본문·이미지 없음)" \
    || { err "reference.odt 에 원본 문서 잔재가 있습니다 — pipeline/strip_reference_odt.py 를 돌리세요"; exit 1; }
  info "ax flake 경유 도구 점검(pandoc/pdftotext)…"
  AXRUN pandoc --version >/dev/null 2>&1 && ok "pandoc (ax flake)"              || warn "pandoc 확인 실패"
  AXRUN pdftotext -v      >/dev/null 2>&1 && ok "pdftotext/pdfinfo (ax flake)"  || warn "poppler 확인 실패"
}

# org → tex → xelatex, build/<FINAL>.pdf 로.
#
# 제출용 정본 PDF 는 이쪽에서 나온다. ODT 트랙은 워드프로세서가 열어 편집할 문서
# (→ DOC → HWP)를 맡고, 조판 품질은 이쪽이 맡는다. 같은 org 정본에서 갈라지므로
# 둘은 경쟁하지 않는다 — 내용이 어긋날 자리가 없다.
#
# texlive 는 호스트에 acmart 가 없다(scheme-medium). 조판 클래스·한글 엔진·활자를
# flake devshell 이 쥐고, 활자를 빌드 입력으로 고정하는 것이 재현성의 핵심이다.
build_tex() {
  local key="$1" org="$DIR/$1.org" base="${FINAL[$1]}"
  [[ -f "$org" ]] || { err "$org 없음"; exit 1; }
  mkdir -p "$BUILD"
  info "[$key] org → tex (emacs ox-latex, acmart manuscript)"
  # 지난 판을 먼저 지운다. grep 파이프가 emacs 의 종료 코드를 삼키기 때문에 "내보내기가
  # 실패했는데 이전 .tex 이 남아 있어 그대로 다시 조판되는" 상태를 파일 존재만으로는
  # 구분할 수 없다. 지우고 시작하면 아래 존재 검사가 그대로 실패 판정이 된다.
  rm -f "$BUILD/$base.tex"
  emacs -Q --batch --script "$PIPE/latex-export.el" "$org" "$BUILD/$base.tex" 2>&1 \
    | grep -E "ERROR|Cannot open" || true
  [[ -f "$BUILD/$base.tex" ]] || { err "[$key] TEX 생성 실패"; exit 1; }
  info "[$key] tex → pdf (xelatex, flake devshell)"
  NIXRUN latexmk -xelatex -interaction=nonstopmode -output-directory="$BUILD" "$BUILD/$base.tex" \
    >/dev/null 2>&1 || { err "[$key] xelatex 실패 — $BUILD/$base.log 확인"; exit 1; }
  local pdf="$BUILD/$base.pdf"
  [[ -f "$pdf" ]] || { err "[$key] PDF 생성 실패"; exit 1; }
  # 판면을 넘어간 표·문단은 LaTeX 로그에만 남고 PDF 에서는 "열이 하나 없는 표" 로만
  # 보인다. 지운 적 없는 내용이 사라지는 종류의 실패라 빌드 때마다 센다.
  local overfull; overfull="$(grep -c 'Overfull \\hbox' "$BUILD/$base.log" || true)"
  [[ "$overfull" -eq 0 ]] || warn "[$key] Overfull hbox ${overfull}건 — 판면을 넘은 표/문단이 있다"
  # 활자에 없는 글자는 로그에만 남고 PDF 에는 빈칸으로 찍힌다. Overfull 과 같은 종류의
  # 실패다 — 페이지는 멀쩡하고 글자만 사라지므로, 눈으로 세는 대신 빌드가 센다.
  local missing; missing="$(grep -c 'Missing character' "$BUILD/$base.log" || true)"
  [[ "$missing" -eq 0 ]] || { err "[$key] Missing character ${missing}건 — 활자에 없는 글자가 빈칸으로 찍혔다:"
    grep 'Missing character' "$BUILD/$base.log" | sort -u | sed 's/^/    /'; exit 1; }
  local pages; pages="$(NIXRUN pdfinfo "$pdf" 2>/dev/null | awk '/^Pages/{print $2}')"
  ok "[$key] $pdf — ${pages}p, $(du -h "$pdf" | cut -f1)"
}

# org → odt → postprocess → pdf, build/<FINAL>.odt 로.
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
  # 활자 계약은 산출물에 적용해야 성립한다. reference.odt 의 styles.xml 만 손보면 ox-odt 가
  # 자기 템플릿에서 만들어 넣는 content.xml 자동 스타일에 Times New Roman 이 그대로 남아,
  # "본문 Pretendard · 코드 D2Coding" 이 최종 ODT/DOC 에서는 지켜지지 않는다.
  info "[$key] odt 활자 지정 (본문 Pretendard · 코드 D2Coding)"
  python3 "$PIPE/set_reference_font.py" "$odt" --prose-font Pretendard --mono-font D2Coding
  # ODT 트랙은 PDF 를 내지 않는다. 조판 정본은 build_tex 가 만들고, 이쪽은 받는 쪽이
  # 열어서 고칠 수 있는 문서를 맡는다 — 그래서 DOC 까지 같이 낸다. HWP 는 이 DOC 을
  # 한글에서 열어 저장하는 마지막 한 걸음이라 자동화 대상에서 뺀다(변환기가 없다).
  info "[$key] odt → doc (libreoffice headless)"
  libreoffice -env:UserInstallation="file:///tmp/lo_submission_$1" \
    --headless --convert-to doc "$odt" --outdir "$DIR" >/dev/null 2>&1
  local doc="$DIR/$1.doc"
  [[ -f "$doc" ]] || { err "[$key] DOC 생성 실패"; exit 1; }
  mv -f "$odt" "$BUILD/$base.odt"
  mv -f "$doc" "$BUILD/$base.doc"
  ok "[$key] $BUILD/$base.odt · $BUILD/$base.doc — $(du -h "$BUILD/$base.odt" | cut -f1) / $(du -h "$BUILD/$base.doc" | cut -f1)"
}

# images/master(생성 원본) → images(문서가 참조하는 판). 원본은 지우지 않는다 —
# 이미지 생성은 비결정적이라 같은 프롬프트로 같은 그림이 다시 나오지 않는다.
cmd_images() {
  [[ -d "$DIR/images/master" ]] || { err "$DIR/images/master 없음 — 생성 원본을 여기에 둡니다"; exit 1; }
  info "[images] 생성 원본 → 문서용으로 축소·양자화"
  python3 "$PIPE/optimize_images.py" "$DIR/images/master" "$DIR/images"
}

cmd_detail() {
  mkdir -p "$BUILD"
  local key label org out
  for key in competency portfolio detail; do
    case "$key" in
      competency) label="Competency" ;;
      portfolio)  label="Portfolio" ;;
      detail)     label="Detail" ;;
    esac
    org="$DIR/$key.org"
    out="$BUILD/KimJunghan_AX_${label}.md"
    [[ -f "$org" ]] || { err "$org 없음"; exit 1; }
    info "[$key-md] org → gfm (pandoc, ax flake)"
    AXRUN pandoc "$org" -f org -t gfm --wrap=none --toc \
      --citeproc --bibliography="$DIR/references.bib" \
      --csl="$PIPE/templates/ieee.csl" \
      -o "$out"
    ok "[$key-md] $out — $(wc -l < "$out") lines, $(du -h "$out" | cut -f1)"
  done
}

# 산출물 검수 — 페이지수, 캡션 번호, :noexport 누출, 연락처/URL.
cmd_verify() {
  local fail=0
  for key in competency portfolio; do
    local base="${FINAL[$key]}" pdf="$BUILD/${FINAL[$key]}.pdf"
    [[ -f "$pdf" ]] || { err "$pdf 없음 — verify 는 산출물이 있어야 성립한다"; fail=1; continue; }
    local txt=""
    txt="$(AXRUN pdftotext -layout "$pdf" - 2>/dev/null || true)"
    # nix develop 경유 poppler가 드물게 성공 코드와 빈 stdout 또는 첫 페이지가 빠진 출력을 돌려준 적이
    # 있다. 후자는 본문이 남아 있으므로 빈 출력 검사만으로는 통과해, 이메일·URL 경고가 실행마다
    # 옮겨 다닌다. 모든 제출 PDF의 1쪽에 있어야 하는 이메일을 sentinel로 삼아 한 번 재시도한다.
    if [[ -z "${txt//[[:space:]]/}" || "$txt" != *"[email removed]"* ]]; then
      sleep 0.2
      txt="$(AXRUN pdftotext -layout "$pdf" - 2>/dev/null || true)"
    fi
    # Poppler 재시도 뒤에도 첫 페이지가 빠지면, 이 호스트에 있는 Ghostscript txtwrite로 판독을
    # 폴백한다. PDF 본문 검사 자체를 건너뛰는 것이 아니라 다른 추출기로 같은 sentinel을 확인한다.
    if [[ -z "${txt//[[:space:]]/}" || "$txt" != *"[email removed]"* ]] && command -v gs >/dev/null; then
      local gs_txt
      gs_txt="$(gs -q -sDEVICE=txtwrite -o - "$pdf" 2>/dev/null || true)"
      # Poppler의 본문·캡션 레이아웃과 Ghostscript의 1쪽 헤더가 서로 보완된다. 어느 한쪽이
      # 누락됐다고 다른 쪽에서 정상 추출한 증거까지 버리지 않도록 합쳐 검수한다.
      txt+=$'\n'
      txt+="$gs_txt"
    fi
    if [[ -z "${txt//[[:space:]]/}" || "$txt" != *"[email removed]"* ]]; then
      err "  PDF 텍스트 추출 실패(2회 Poppler + Ghostscript 첫 페이지 누락): $pdf"; fail=1; continue
    fi
    local pages; pages="$(AXRUN pdfinfo "$pdf" 2>/dev/null | awk '/^Pages/{print $2}')"
    echo "── $base.pdf (${pages}p) ──"
    # 판면 크기. 제출처가 A4 를 전제하므로 letterpaper 로 새는 것은 통과시키지 않는다.
    # acmart 는 letterpaper 를 클래스 안에서 고정하고, geometry 재호출이 빠지면 조용히
    # 되돌아간다 — 페이지는 나오고 여백만 달라져서 눈으로는 잘 안 잡힌다.
    # A4 는 595.276 x 841.89pt 이고 pdfinfo 는 이를 정수로 반올림해 보고한다(595 x 841).
    # 정확한 문자열 비교는 늘 실패하므로 ±2pt 허용으로 본다 — letterpaper(612 x 792)와는
    # 그 폭보다 훨씬 멀어서 구분에 문제가 없다.
    local psize; psize="$(AXRUN pdfinfo "$pdf" 2>/dev/null | awk '/^Page size/{print $3, $5}')"
    if awk -v s="$psize" 'BEGIN{split(s,d," "); exit !(d[1]>593 && d[1]<598 && d[2]>840 && d[2]<844)}'; then
      ok "  A4 판면 (${psize/ / x } pt)"
    else
      err "  A4 아님: ${psize/ / x } pt (A4 = 595 x 842, letter = 612 x 792)"; fail=1
    fi
    # 조판 로그의 조용한 실패 — 활자에 없는 글자, 판면을 넘은 상자.
    local log="$BUILD/$base.log"
    if [[ -f "$log" ]]; then
      local miss over
      miss="$(grep -c 'Missing character' "$log" || true)"
      over="$(grep -c 'Overfull \\hbox' "$log" || true)"
      [[ "$miss" -eq 0 ]] && ok "  활자 누락 없음" || { err "  Missing character ${miss}건"; fail=1; }
      [[ "$over" -eq 0 ]] && ok "  판면 초과 없음" || warn "  Overfull hbox ${over}건"
    fi
    # 별표 누출 (Org 굵게가 렌더 안 되고 별표로 샌 경우)
    if grep -q '[*]' <<<"$txt"; then warn "  별표(*) 누출 — 굵게 렌더 실패 의심"; fail=1; else ok "  별표 누출 없음"; fi
    # :noexport 프롬프트/메모 누출
    if grep -qiE 'noexport|생성 프롬프트|IMAGE PROMPT|TODO|검토 메모' <<<"$txt"; then warn "  :noexport 내용 누출 의심"; fail=1; else ok "  :noexport 누출 없음"; fi
    # 연락처 + 대표 URL. set -o pipefail 아래에서 `echo "$txt" | grep -q`는 grep 조기 종료 뒤
    # echo가 SIGPIPE로 실패해 거짓 경고를 낼 수 있으므로 here-string으로 검사한다.
    grep -q '[email removed]' <<<"$txt" && ok "  이메일 노출" || { warn "  이메일 안 보임"; fail=1; }
    grep -q 'github.com/junghan0611' <<<"$txt" && ok "  GitHub URL 노출" || { warn "  GitHub URL 안 보임"; fail=1; }
    # 캡션 번호
    grep -qE '표 [0-9]|그림 [0-9]' <<<"$txt" && ok "  캡션 연번(표/그림 N) 존재" || warn "  캡션 연번 없음(이미지/표 미포함이면 정상)"
    # 편집면(ODT/DOC)도 산출물이다. PDF 만 보고 통과시키면 받는 쪽이 여는 문서가 검사 밖에 남는다.
    local odt="$BUILD/$base.odt"
    if [[ -f "$odt" ]]; then
      # 활자 계약 — 선언(<style:font-face>)이 아니라 실제 사용(style:font-name=)을 센다.
      # 쓰이지 않는 선언 한 줄이 남는 것은 조판에 영향이 없고, 그것까지 실패로 세면
      # 검사가 늘 빨개져서 아무도 읽지 않는 검사가 된다.
      local times; times="$(unzip -p "$odt" content.xml styles.xml 2>/dev/null | grep -c 'font-name[^=]*="Times New Roman"' || true)"
      [[ "$times" -eq 0 ]] && ok "  ODT 활자 계약 (Times 사용 0건)" \
        || { err "  ODT 에 Times New Roman 사용 ${times}건 — set_reference_font.py 미적용"; fail=1; }
      # 이미지가 참조만 되고 실제로 안 담기면 받는 쪽에서 빈 상자로 열린다.
      local imgs; imgs="$(unzip -l "$odt" 2>/dev/null | grep -cE 'Images/|Pictures/' || true)"
      [[ "$imgs" -gt 0 ]] && ok "  ODT 이미지 내부 임베드 ${imgs}장" || warn "  ODT 에 임베드된 이미지 없음"
    else
      err "  $odt 없음 — 편집면이 빠졌다"; fail=1
    fi
    [[ -f "$BUILD/$base.doc" ]] || { err "  $BUILD/$base.doc 없음"; fail=1; }
  done
  local label md
  for label in Competency Portfolio Detail; do
    md="$BUILD/KimJunghan_AX_${label}.md"
    if [[ -f "$md" ]]; then
      echo "── KimJunghan_AX_${label}.md ──"
      grep -qiE 'noexport|IMAGE PROMPT|생성 프롬프트|검토 메모' "$md" \
        && { warn "  :noexport 누출 의심"; fail=1; } || ok "  :noexport 누출 없음"
      grep -q 'github.com/junghan0611' "$md" && ok "  자체 프로젝트 공개 링크 존재" || warn "  공개 링크 없음"
    else
      err "  $md 없음"; fail=1
    fi
  done
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
  local COMP="$BUILD/KimJunghan_AX_Competency.pdf" PORT="$BUILD/KimJunghan_AX_Portfolio.pdf"
  local MDC="$BUILD/KimJunghan_AX_Competency.md" MDP="$BUILD/KimJunghan_AX_Portfolio.md" MDD="$BUILD/KimJunghan_AX_Detail.md"
  for f in "$COMP" "$PORT" "$MDC" "$MDP" "$MDD"; do [[ -f "$f" ]] || { err "$f 없음 — 먼저 ./run.sh all"; exit 1; }; done
  local S="$DIR/$STAGE"
  rm -rf "$DIR/.package"; mkdir -p "$S"/{images,pipeline/templates,outputs}
  # allowlist 복사
  cp "$DIR/README.package.md" "$S/README.md"
  cp "$DIR/AGENTS.package.md" "$S/AGENTS.md"
  cp "$MDC" "$MDP" "$MDD"   "$S/"
  # Org 정본은 패키지 루트에 둔다 — 작업 저장소와 같은 배치여야 한다.
  #
  # 한동안 sources/ 아래에 담았는데, 그러면 받는 쪽에서 ./run.sh 가 아무것도 못 찾는다:
  # run.sh 는 정본을 저장소 루트에서 찾고, 정본 안의 #+INCLUDE "pipeline/preamble.org" 와
  # [[file:images/...]] 는 정본이 있는 디렉터리 기준으로 풀린다. 정본만 한 층 내려가면
  # 그 세 경로가 한꺼번에 어긋난다. 보기 좋은 배치보다 "풀어서 그대로 도는" 쪽이 이
  # 패키지의 주장이므로, 배치를 저장소와 일치시킨다.
  cp "$DIR/competency.org" "$DIR/portfolio.org" "$DIR/detail.org" "$S/"
  local image_count=0
  while IFS= read -r -d '' image; do
    cp "$image" "$S/images/"
    image_count=$((image_count + 1))
  done < <(find "$DIR/images" -maxdepth 1 -type f \
    \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) -print0)
  [[ $image_count -gt 0 ]] || warn "images/ 비어있음 (이미지 생성 전)"
  cp "$DIR/references.bib" "$S/"
  cp "$DIR/run.sh"         "$S/run.sh"
  # 파이프라인 전체를 넣는다. 산출물만 보내면 "이 문서가 예쁘다" 로 끝나지만, 변환기와
  # 그 환경까지 들어가면 받는 쪽이 같은 소스에서 같은 세트를 다시 만들 수 있다 —
  # 문서 작성·배포가 업무에 들어 있는 자리에 내는 자료라 이쪽이 본체다.
  cp "$PIPE/proposal-export.el" "$PIPE/latex-export.el" "$PIPE/preamble.org" \
     "$PIPE/odt_postprocess.py" "$PIPE/set_reference_font.py" \
     "$PIPE/optimize_images.py" "$PIPE/strip_reference_odt.py" "$S/pipeline/"
  cp "$PIPE/templates/ieee.csl" "$PIPE/templates/reference.odt" "$S/pipeline/templates/"
  # flake.nix 가 조판 클래스(acmart)·한글 엔진(xetexko)·활자(Pretendard·D2Coding)를
  # 빌드 입력으로 고정하고, flake.lock 이 그 nixpkgs 를 특정 리비전에 묶는다. lock 이
  # 빠지면 받는 쪽은 "같은 선언"만 받고 "같은 입력"은 못 받는다 — 활자와 texlive 판이
  # 달라질 수 있으므로, 그 상태를 재현이라 부를 수 없다.
  cp "$DIR/flake.nix" "$DIR/flake.lock" "$S/"
  cp "$COMP" "$PORT" "$S/outputs/"
  # 편집 가능한 표면(ODT·DOC)도 같이 낸다. HWP 는 이 DOC 을 한글에서 열어 저장한다.
  for key in competency portfolio; do
    for ext in odt doc; do
      [[ -f "$BUILD/${FINAL[$key]}.$ext" ]] && cp "$BUILD/${FINAL[$key]}.$ext" "$S/outputs/"
    done
  done
  # 배포본 run.sh 에서 로컬 절대경로 기본값 제거 (PATH/사용자 지정으로 동작)
  sed -i -E 's#(AX_FLAKE=")\$\{AX_FLAKE:-[^}]*\}(")#\1${AX_FLAKE:-}\2#; s#(EMACSDIR=")\$\{EMACSDIR:-[^}]*\}(")#\1${EMACSDIR:-}\2#; s#(DOOMDIR=")\$\{DOOMDIR:-[^}]*\}(")#\1${DOOMDIR:-}\2#' "$S/run.sh"
  # MANIFEST.sha256 (재현 가능한 정렬)
  ( cd "$S" && find . -type f ! -name MANIFEST.sha256 | LC_ALL=C sort | xargs sha256sum > MANIFEST.sha256 )
  # 절대경로 누출 검사 — PM 지정 대상(README·AGENTS·MD·MANIFEST·run.sh). 홈 경로 리터럴을
  # 소스에 두지 않으려 $HOME 로 검색한다(패키지된 run.sh 자신에 절대경로가 안 남게).
  # 스테이지 전체를 훑는다. 예전에는 지정한 다섯 파일만 봤는데, 그 목록에 없는 곳 —
  # 정본 Org 와 pipeline/ — 이 정작 로컬 경로가 남기 쉬운 자리다. 검사 대상을 손으로
  # 나열하는 방식은 패키지에 파일이 하나 늘 때마다 조용히 구멍이 생긴다.
  # 정본 Org 는 GLG 원문을 한 글자도 바꾸지 않고 보존하는 구역(:noexport:)을 품고 있어,
  # 그 안의 로컬 경로는 파이프라인이 지울 대상이 아니라 사람이 판단할 대상이다. 그래서
  # 정본은 경고로 세어 눈에 남기고, 나머지 — 도구·문서·산출물 — 는 실패로 막는다.
  info "절대경로(사용자 홈) 누출 검사…"
  local leak_src leak_rest
  leak_src=$(grep -rIl "$HOME" "$S"/*.org 2>/dev/null || true)
  leak_rest=$(grep -rIl "$HOME" "$S" --exclude='*.org' 2>/dev/null || true)
  [[ -z "$leak_rest" ]] && ok "도구·문서·산출물에 절대경로 누출 없음" \
    || { err "절대경로 발견 — 패키지에 로컬 경로가 남았다:"; echo "$leak_rest" | sed "s#^$S/#    #"; exit 1; }
  [[ -z "$leak_src" ]] && ok "정본 Org 에도 절대경로 없음" || {
    warn "정본 Org 에 로컬 경로가 있다(원문 보존 구역 — 내보낼지 사람이 결정한다):"
    grep -rn "$HOME" "$S"/*.org 2>/dev/null | sed "s#^$S/#    #"; }
  # zip
  local zip="$BUILD/KimJunghan_AX_Evidence_Package.zip"
  rm -f "$zip"; ( cd "$DIR/.package" && zip -qr "$zip" KimJunghan_AX_Evidence_Package -x '*.DS_Store' )
  ok "ZIP: $zip ($(du -h "$zip" | cut -f1))"
  info "ZIP 내용:"; ( cd "$S" && find . -type f | LC_ALL=C sort | sed 's#^\./#    #' )
}

cd "$DIR"
case "${1:-all}" in
  check)      cmd_check ;;
  competency) build_tex competency; build_pdf competency ;;
  portfolio)  build_tex portfolio;  build_pdf portfolio ;;
  detail)     cmd_detail ;;
  images)     cmd_images ;;
  all)        build_tex competency; build_pdf competency
              build_tex portfolio;  build_pdf portfolio
              cmd_detail; cmd_verify ;;
  verify)     cmd_verify ;;
  package)    cmd_package ;;
  clean)      cmd_clean ;;
  *) echo "사용법: ./run.sh {check|competency|portfolio|detail|images|all|verify|package|clean}"; exit 1 ;;
esac
