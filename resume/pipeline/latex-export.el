;;; latex-export.el --- Org → article XeLaTeX 이력서 조판 -*- lexical-binding: t; -*-

;; 이력서 정본(resume.org, targets/*.org) 하나를 PDF 한 장으로 옮기는 유일한 변환기.
;;
;; nhn/ 의 제출 파이프라인과 같은 자리를 맡지만 클래스가 다르다. 저쪽은 acmart(논문
;; 조판)이고 이쪽은 article 이다. 조판 선언은 전부 pipeline/preamble.org 가 쥐고,
;; 여기서는 클래스 등록과 Org 백엔드의 기본값 교정만 한다.
;;
;; 사용법:
;;   emacs -Q --batch --script latex-export.el resume.org build/KimJunghan_Resume.tex

(require 'org)
(require 'ox-latex)

;; -Q 로 뜬 배치 Emacs 에서 export 가 실패하면 org AST 백트레이스가 수백 MB 로 쏟아져
;; 진짜 오류 줄을 덮는다. 이력서는 인용 처리기가 필요 없으므로 Doom 코어를 얹지 않는다.
(setq debug-on-error nil
      backtrace-on-error-noninteractive nil
      org-export-with-broken-links t
      org-confirm-babel-evaluate nil)

;; 조판 선언은 preamble.org 가 전부 쥔다. Org 가 기본으로 밀어 넣는 패키지 목록은
;; 그 선언과 두 번 겹치거나(색·하이퍼링크) 순서를 어긋나게 하므로(fontspec 앞의 inputenc)
;; 클래스 등록에서 비워 두고, 필요한 것만 preamble 이 명시적으로 부른다.
(setq org-latex-default-packages-alist nil
      org-latex-packages-alist nil)

(add-to-list 'org-latex-classes
             '("cvpaper"
               "\\documentclass{article}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))

;; 표는 booktabs 로. 세로줄 없는 표가 이력서에서 훨씬 조용하게 읽힌다.
(setq org-latex-tables-booktabs t
      org-latex-default-table-environment "tabular")

;; Org 표는 tabular 로 나가고 tabular 의 열은 줄바꿈을 하지 않는다. 셀 하나가 길면 표
;; 전체가 판면을 넘어 오른쪽으로 흘러나가고, 넘어간 열은 종이 밖에서 잘린다 — 화면에서는
;; "마지막 열이 없는 표" 로만 보여서 내용을 지운 적이 없는데 내용이 사라진다.
;;
;; 표마다 #+attr_latex 을 손으로 다는 대신 조판 계층에서 해결한다: 모든 표를 판면 폭에
;; 맞는 tabularx 로 바꾸고, 남는 폭을 설명 열에만 준다.
;;
;; 어느 열을 X 로 줄지가 실제 분량을 좌우한다. 전부 X 로 균등 분배하면 "TypeScript" 한
;; 단어가 드는 Stack 열이 설명 열과 같은 폭을 가져가고, 설명이 두 줄로 접히면서 열두 행짜리
;; 표가 한 쪽을 통째로 먹는다. 그래서 세 열 이상이면 첫 열(이름)과 마지막 열(스택)을
;; 자연폭으로 두고 가운데만 늘린다. 두 열짜리 표는 늘릴 자리가 마지막 열뿐이다.
(defun cv/table-fit-to-linewidth (data _backend _info)
  "본문 표를 판면 폭에 맞춰 줄바꿈되게 바꾼다."
  (replace-regexp-in-string
   "\\\\begin{tabular}{\\([^}]*\\)}"
   (lambda (m)
     (let* ((spec (match-string 1 m))
            ;; 정렬 문자만 남긴다 — 세로줄(|)이나 @{} 는 X 로 바꾸는 순간 의미가 없다.
            (cols (seq-filter (lambda (c) (memq c '(?l ?c ?r)))
                              (string-to-list spec)))
            (n (length cols)))
       (cond
        ((< n 2) m)
        ((= n 2) (format "\\begin{tabularx}{\\linewidth}{%cX}" (car cols)))
        (t (format "\\begin{tabularx}{\\linewidth}{%c%s%c}"
                   (car cols)
                   (make-string (- n 2) ?X)
                   (car (last cols)))))))
   data t t))

(defun cv/table-close-tabularx (data _backend _info)
  ;; LITERAL 인자를 주는 자리라 치환문은 정규식이 아니다 — 여기서 "\\\\end" 라고 쓰면
  ;; 역슬래시 두 개가 그대로 출력되어 tabularx 가 제 끝을 못 찾고 파일 끝까지 스캔한다.
  (replace-regexp-in-string "\\\\end{tabular}" "\\end{tabularx}" data t t))

(add-to-list 'org-export-filter-table-functions #'cv/table-fit-to-linewidth)
(add-to-list 'org-export-filter-table-functions #'cv/table-close-tabularx)

(let* ((source (pop command-line-args-left))
       (output (pop command-line-args-left)))
  (unless (and source output)
    (error "usage: latex-export.el SOURCE.org OUTPUT.tex"))
  (make-directory (file-name-directory (expand-file-name output)) t)
  (find-file source)
  (let ((org-export-exclude-tags '("noexport")))
    ;; 정본은 표제 블록을 \cvheader 로 직접 들고 있다. Org 가 만드는 자동 타이틀은 그 위에
    ;; 하나 더 찍히므로 끈다. 목차도 끈다 — 두세 쪽짜리 이력서가 첫 장을 "Contents" 에
    ;; 쓰는 일은 없어야 한다.
    (org-export-to-file 'latex output nil nil nil nil
                        '(:with-title nil :with-author nil :with-date nil
                          :with-tags nil :with-toc nil))))
