;;; latex-export.el --- Org → acmart XeLaTeX 조판 -*- lexical-binding: t; -*-

;; 같은 Org 정본에서 ODT 트랙과 나란히 도는 두 번째 표면. ODT 는 워드프로세서가 읽는
;; 문서(→ DOC → HWP)를 만들고, 이쪽은 제출용 정본 PDF 를 만든다. 둘은 경쟁하지 않는다.
;;
;; 클래스 배선은 ax(ax.junghanacs.com) 의 build.el 에서 가져왔다. 거기서 이미 증명된
;; 조판이고, 공개면으로 되돌릴 때 두 번 일하지 않으려면 같은 배선이어야 한다.
;;
;; 사용법:
;;   emacs -Q --batch --script latex-export.el portfolio.org build/Foo.tex

(require 'seq)

;; 환경 부트스트랩은 ODT 트랙과 공유한다. `-Q' 로 뜬 Emacs 에는 citeproc 이 없어
;; `#+cite_export: csl' 을 만나는 순간 export 가 멈추고, 인용 처리기가 두 표면에서
;; 서로 다르면 같은 정본에서 나온 PDF 와 ODT 의 참고문헌이 어긋난다. proposal-export.el
;; 은 Doom 의 straight 빌드를 load-path 에 얹고 citar·oc-csl 을 세팅하는데, 그 파일의
;; CLI 진입점은 첫 인자가 "export" 일 때만 발동하므로 여기서 불러도 아무것도 실행되지
;; 않는다 — 환경만 얻고 조판은 아래에서 우리가 정한다.
(load (expand-file-name "proposal-export.el"
                        (file-name-directory (file-truename load-file-name)))
      nil t)

(require 'org)
(require 'ox-latex)

;; proposal-export.el 이 켜 둔 debug-on-error 를 되돌린다. 켜진 채로 export 가 실패하면
;; org AST 백트레이스가 수백 MB 로 쏟아져 진짜 오류 줄을 덮는다.
(setq debug-on-error nil
      backtrace-on-error-noninteractive nil
      org-export-with-broken-links t)

;; acmart 는 newtx 를 로드하고, newtx 는 Org 가 기본으로 넣는 amssymb 와 심볼 정의가
;; 충돌한다. Org 쪽 목록에서 빼는 편이 안전하다 — acmart 가 필요한 심볼을 이미 준다.
(setq org-latex-default-packages-alist
      (seq-remove (lambda (pkg) (equal (cadr pkg) "amssymb"))
                  org-latex-default-packages-alist))

;; acmart 는 ACM 이 US letter 만 쓰기 때문에 letterpaper 를 클래스 안에서 고정하고,
;; a4paper 를 클래스 옵션으로 받지 않는다. geometry 는 이미 로드된 뒤라
;; \usepackage[a4paper]{geometry} 는 option clash 로 죽는다. 남는 길은 \geometry 재호출뿐.
;;
;; oneside 를 같이 잡는 이유: manuscript 는 twoside 라 홀·짝 페이지의 좌우 여백이
;; 37pt(1.3cm) 어긋난다. 제본해서 펼쳐 읽으면 맞지만 이 문서는 화면에서 스크롤로 읽힌다.
;; 그때는 페이지가 넘어갈 때마다 본문 블록이 좌우로 흔들리는 것으로만 보인다.
;; `oneside' 는 클래스 옵션이지 geometry 키가 아니다(→ xkeyval: `oneside' undefined in
;; families `Gm'). geometry 에서 같은 뜻을 내는 키는 twoside 불리언이다.
(defconst nhn/geometry
  "\\geometry{a4paper,twoside=false,left=3cm,right=3cm,top=2.8cm,bottom=2.8cm}")

(add-to-list 'org-latex-classes
             `("nhnpaper"
               ,(concat "\\documentclass{acmart}\n" nhn/geometry)
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; 이미지는 캡션과 함께 figure 로 띄우되, 본문 폭을 넘지 않게 한다. Org 소스에는
;; ODT 용 #+attr_odt 만 붙어 있어서 LaTeX 백엔드는 원본 픽셀 크기로 내보낸다 — 16:9
;; 인포그래픽이 그대로 나가면 페이지를 넘긴다. 문서마다 attr_latex 을 손으로 다는 대신
;; 기본값을 여기서 고정한다.
(setq org-latex-image-default-width "\\linewidth"
      org-latex-image-default-option ""
      org-latex-caption-above nil)

;; 표는 booktabs 로. acmart 가 booktabs 를 이미 로드한다.
(setq org-latex-tables-booktabs t
      org-latex-default-table-environment "tabular")

;; Org 표는 `tabular' 로 나가고 tabular 의 열은 줄바꿈을 하지 않는다. 셀 하나가 길면
;; 표 전체가 판면을 넘어 오른쪽으로 흘러나가고, 넘어간 열은 종이 밖에서 잘린다 —
;; 화면에서는 "마지막 열이 없는 표" 로만 보여서, 내용을 지운 적이 없는데 내용이 사라진다.
;;
;; 표마다 #+attr_latex 을 손으로 다는 대신 조판 계층에서 해결한다: 모든 표를 판면 폭에
;; 맞는 tabularx 로 바꾸고, 첫 열만 원래 정렬을 지키고 나머지를 X(가변폭·줄바꿈) 로 준다.
;; 첫 열은 번호나 항목명처럼 짧은 것이 오는 자리라 좁게 두는 편이 읽기 좋다.
(defun nhn/table-fit-to-linewidth (data _backend _info)
  "본문 표를 판면 폭에 맞춰 줄바꿈되게 바꾼다."
  (replace-regexp-in-string
   "\\\\begin{tabular}{\\([^}]*\\)}"
   (lambda (m)
     (let* ((spec (match-string 1 m))
            ;; 정렬 문자만 남긴다 — 세로줄(|)이나 @{} 는 X 로 바꾸는 순간 의미가 없다.
            (cols (seq-filter (lambda (c) (memq c '(?l ?c ?r)))
                              (string-to-list spec))))
       (if (< (length cols) 2)
           m
         (format "\\begin{tabularx}{\\linewidth}{%c%s}"
                 (car cols)
                 (make-string (1- (length cols)) ?X)))))
   data t t))

(defun nhn/table-close-tabularx (data _backend _info)
  ;; LITERAL 인자를 주는 자리라 치환문은 정규식이 아니다 — 여기서 "\\\\end" 라고 쓰면
  ;; 역슬래시 두 개가 그대로 출력되어 tabularx 가 제 끝을 못 찾고 파일 끝까지 스캔한다.
  (replace-regexp-in-string "\\\\end{tabular}" "\\end{tabularx}" data t t))

(add-to-list 'org-export-filter-table-functions #'nhn/table-fit-to-linewidth)
(add-to-list 'org-export-filter-table-functions #'nhn/table-close-tabularx)

;; tabularx 는 acmart 가 로드하지 않는다. X 열은 이것 없이는 미정의 열 지정자다.
;; ragged2e 를 같이 얹는 이유: X 열의 기본은 양쪽정렬인데, 좁은 열에서 한글을 양쪽으로
;; 늘리면 한 줄에 두세 어절만 남으면서 어절 사이가 손가락만큼 벌어진다.
;;
;; `org-splice-latex-header' 는 리스트 항목을 \usepackage 로 조립하고 문자열 항목은
;; 프리앰블에 그대로 흘려보낸다. 아래 정의는 패키지가 아니라 열 타입 재정의라 문자열로 둔다.
(dolist (pkg '(("" "tabularx" t) ("" "ragged2e" t) ("" "etoolbox" t)))
  (add-to-list 'org-latex-packages-alist pkg t))

(add-to-list 'org-latex-packages-alist
             (concat
              ;; X 열을 위끝 정렬 + 왼끝맞춤 문단으로. 표 안의 긴 한국어 문장이
              ;; 자연스럽게 접히고, 행 높이가 제각각인 표에서 셀이 위로 정렬된다.
              "\\renewcommand{\\tabularxcolumn}[1]"
              "{>{\\RaggedRight\\arraybackslash}p{#1}}\n"
              ;; 표는 본문보다 한 급 작게. 열이 많은 표에서 이 한 급이 판면을 살린다.
              ;; arraystretch 를 같이 올리는 이유: X 열이 생기면 긴 셀이 두세 줄로 접히는데
              ;; 기본 행 간격으로는 접힌 줄과 다음 행의 첫 줄이 같은 간격으로 붙어서,
              ;; 어디까지가 한 행인지 눈으로 끊기지 않는다.
              "\\AtBeginEnvironment{tabularx}{\\small\\renewcommand{\\arraystretch}{1.25}}\n"
              ;; 캡션 표제는 한국어로. ODT 트랙은 org-odt-category-map-alist 로 이미
              ;; "그림 1"·"표 1" 을 찍는다 — 같은 정본에서 나온 두 PDF 가 캡션만 다른
              ;; 언어로 나가면, 읽는 사람에게는 두 문서가 서로 다른 파이프라인에서
              ;; 나온 것으로 보인다.
              ;; 캡션 표제는 \figurename 이 아니라 caption 패키지가 쥐고 있다. acmart 가
              ;; \captionsetup{name=Figure} 로 박아두기 때문에 \renewcommand{\figurename}
              ;; 은 조용히 무시되고 PDF 에는 계속 "Fig. 1" 이 찍힌다 — 같은 층에서 덮어야 한다.
              "\\captionsetup[figure]{name=그림,labelsep=period}\n"
              "\\captionsetup[table]{name=표,labelsep=period}")
             t)

(let* ((source (pop command-line-args-left))
       (output (pop command-line-args-left)))
  (unless (and source output)
    (error "usage: latex-export.el SOURCE.org OUTPUT.tex"))
  (make-directory (file-name-directory (expand-file-name output)) t)
  (find-file source)
  (let ((org-export-exclude-tags '("noexport")))
    ;; 정본은 acmart 타이틀 블록을 직접 들고 있다(#+begin_export latex). Org 가 만드는
    ;; 자동 타이틀은 그 위에 하나 더 찍히므로 끈다. 목차도 끈다 — 4쪽 제출본이 첫 장을
    ;; 두 줄짜리 "Contents" 에 쓰는 일은 없어야 한다.
    (org-export-to-file 'latex output nil nil nil nil
                        '(:with-title nil :with-author nil :with-date nil
                          :with-tags nil :with-toc nil))))
