;; facesets
;;; リストの回転
(defun list-rotate-forward (ring)
  (let ((item (car ring))
        (last (last ring)))
    (setcdr last (list item))
    (cdr ring)))

(defun list-rotate-backward (ring)
  (let ((item (car (last ring)))
        (last2 (last ring 2)))
    (setcdr last2 nil)
    (cons item ring)))

;;; フォントの回転
(defvar kana-font-set
  (remove-if-not
   (lambda (x) (find-font (font-spec :family x)))
   '(;; fontconfig
    "ヒラギノ角ゴ Pro" ;; Hiragino Kaku Gothic
    "小塚ゴシック Pr6N" ;; Kozuka Gothic Pr6N
    "ヒラギノ明朝 Pro" ;; Hiragino Mincho
    "小塚明朝 Pr6N" ;; Kozuka Mincho Pr6N
    "Meiryo"
     ;; "PMinIWA-HW-Md" ;; "PMinIWA-Md" ← 非固定幅
    "Iwata SeichouF Pro"
     "IPA明朝" "IPAゴシック"
     ;; "メイリオ"
     "Kazuraki SPN"
     ;; "Mio W4"
     "Ryo Text PlusN"
     "Ryo Gothic PlusN"
     "Ryo Display PlusN"
     ;; ;; Macintosh
     ;; "Hiragino Kaku Gothic ProN"
     ;; "Hiragino Maru Gothic ProN"
     ;; "Hiragino Mincho ProN"
     ;; ;; Windows
     ;; "小塚明朝 Pr6N R" 
     ;; "小塚ゴシック Pr6N R"
     )))

(defvar kanji-font-set
  (append 
   kana-font-set
   (remove-if-not
    (lambda (x) (find-font (font-spec :family x)))
    '("Hanazono Mincho OT xProN"
      ;;"HanaMin"
      ))))

;;(defvar font-size-set '(12 16 20 28 40))
(defvar font-size-set '(12 14 15 16 18 20 22 24 28 40 48))

;;; フォント幅テスト用の文字列。|
;;; 1234567890123456789012345678|
;; ぴったり合う位置の計算
;; ASCIIの文字幅 (x * 0.6), 漢字の幅 (x * 1.2)
;;     size ASCII 漢字
;; 0.6
;;       12   7.2  14.4 OK.
;;       14   8.4  16.8 (なぜか14)
;;       15   9.0  18.0 OK.
;;       16   9.6  19.2 NG
;;       18  10.8  21.6 (なぜか18)
;;       20  12.0  24   OK.
;;       22  13.2  26.4 OK
;;       24  14.4  28.8 (なぜか24)
(defvar ascii-font-set
  (remove-if-not
   (lambda (x) (find-font (font-spec :family x)))
   '(;; Programmer's Top 10 Fonts.
     "DejaVu Sans Mono"
     ;; "Monaco"
     "Anonymous Pro"
     "Droid Sans Mono"
     "Andale Mono"
     "Inconsolata"
     ;; other
     "Consolas"
     ;; Macintosh
     "Menlo"
     ;; crap
     "Zentraedi"
     )))

(defun rotate-ascii-font (arg)
  (rotate-and-update-fontset 'ascii-font-set arg))
(defun rotate-kana-font (arg)
  (rotate-and-update-fontset 'kana-font-set arg))
(defun rotate-kanji-font (arg)
  (rotate-and-update-fontset 'kanji-font-set arg))
(defun rotate-font-size (arg)
  (rotate-and-update-fontset 'font-size-set arg))

(defun face-font-rescale (factor)
  (setq face-font-rescale-alist
        `(;;(,(font-spec :family "DejaVu Sans Mono") . 0.833333)
          ;;(,(font-spec :family "Droid Sans Mono") . 0.833333)
          ("ヒラギノ.*" . ,factor)
          ("りょう.*" ,factor)
          ("小塚.*" . ,factor)
          ("Hiragino.*" . ,factor)
          ("Ryo.*" . ,factor)
          ("SimSun.*" . ,factor)
          ("Hana.*" . ,factor)
          ("花園.*" . ,factor)
          ("Kazuraki.*" . ,factor)
          ("メイリオ.*" . ,factor)
          ("Mio.*" . ,factor)
          ("Iwata.*" . ,factor)
          ("PMinIwa.*" . ,factor)
          ("EUDC.*" . ,factor)
          ("Monaco.*" . ,factor)
          )))

(face-font-rescale 1.0)

(defun rotate-and-update-fontset (target arg)
  "指定されたシンボルのリストを回転させる。"
  (set target 
       (if (= arg 4) (list-rotate-backward (eval target))
         (list-rotate-forward (eval target))))
  (update-fontset)
  (car (eval target)))

(defun update-fontset ()
  "自分の好みのフォントセットに変更する。"
  (interactive)
  (let ((size (car font-size-set))
        (ascii (car ascii-font-set))
        (kanji (car kanji-font-set))
        (kana  (car kana-font-set))
        (fs "fontset-startup"))
    (my-update-fontset fs size ascii kanji kana)
    (set-frame-parameter nil 'font fs)))

(defun my-update-fontset (fs size ascii kanji kana)
  "自分の好みのフォントセットに変更する。"
  (interactive)
  (set-fontset-font fs '(    #x0 .   #x5ff) (font-spec :size size :family ascii))
  (set-fontset-font fs '( #x1700 .  #x171f) (font-spec :family "Quivira")) ;; Tagalog
  (set-fontset-font fs '( #x1720 .  #x1c4f) (font-spec :family "Code2000"))
  (set-fontset-font fs '( #x2000 .  #x33ff) (font-spec :family "Code2000") nil 'prepend)
  ;; Box Drawing (╰╫╯)+ Block Elements (█▅▓) + Geometric Shapes (◯◎◉▣). DejaVu mono is nice.
  (set-fontset-font fs '( #x2500 .  #x25FF) (font-spec :family "DejaVu Sans Mono") nil 'prepend)
  ;; CJK Symbols and Punctuation, lol, but some kana font have no cjk punctuation! force to code2000
  (set-fontset-font fs '( #x3000 .  #x303f) (font-spec :family "Code2000"))
  (set-fontset-font fs '( #x3040 .  #x30FF) (font-spec :family kana))
  (set-fontset-font fs '( #x3400 .  #x9fff) (font-spec :family kanji))
  (set-fontset-font fs '( #xa000 .  #xfffd) (font-spec :family "Code2000"))
  (set-fontset-font fs '(#x10000 . #x1ffff) (font-spec :family "Code2001") nil 'append)
  ;; CJK Unified Ideographs Extension B (U+20000 to U+2A6DF)
  ;; CJK Unified Ideographs Extension C, CJK Unified Ideographs Extension D,CJK Compatibility Ideographs Supplement
  (set-fontset-font fs '(#x20000 . #x2fffd) (font-spec :family "HanaMin"))
  (set-fontset-font fs '(#x20000 . #x2fffd) (font-spec :family kanji) nil 'prepend)
  ;; Quivira have many symbols
  (set-fontset-font fs '(#x250 . #x1f100) (font-spec :family "Quivira") nil 'append)
  fs
  )

(update-fontset)

;;; 回転コマンド
(defvar rotate-command-set
  '((rotate-ascii-font . "ASCII Font")
    (rotate-kana-font . "かな Font")
    (rotate-kanji-font . "漢字 Font")
    (rotate-font-size . "Font Size"))
  "回転させる命令の引数。後方向は prefix-args の引数が付加される。")

(defun rotate-command-set (arg)
  (interactive "p")
  (message "arg=%s" arg)
  (setq rotate-command-set
        (if (= arg 4) (list-rotate-backward rotate-command-set)
          (list-rotate-forward rotate-command-set)))
  (message "Rotate Command/Set = %s" (cdar rotate-command-set)))

(global-set-key "\M-\S-f" 'rotate-command-set)
(global-set-key "\M-\S-b" (lambda () 
                            (interactive) (rotate-command-set 4)))

(defun rotate-command-run (arg)
  (interactive "p")
  (let* ((command (caar rotate-command-set))
         (result (funcall command arg))
         (name (cdar rotate-command-set)))
    (message "%s = %s" name result)))

(global-set-key "\M-\S-n" 'rotate-command-run)
(global-set-key "\M-\S-p" (lambda ()
                            (interactive) (rotate-command-run 4)))

(defun show-current-font-settings ()
  "Show my font settings."
  (interactive)
  (let ((sz (car font-size-set))
        (ascii (car ascii-font-set))
        (kanji (car kanji-font-set))
        (kana  (car kana-font-set)))
    (message (concat
	      (propertize "フォント幅テスト用の文字列。|" 'face 'font-lock-comment-face)
	      (propertize " Тест на ширину\n" 'face 'font-lock-function-name-face)
	      (propertize "1234567890123456789012345678|" 'face 'font-lock-comment-face) "\n"
	      (propertize "ASCII:" 'face 'font-lock-function-name-face) "\t" (propertize "%s" 'face 'font-lock-string-face) "\n"
	      (propertize "かな:" 'face 'font-lock-function-name-face) "\t" (propertize "%s" 'face 'font-lock-string-face) "\n"
	      (propertize "漢字:" 'face 'font-lock-function-name-face) "\t" (propertize "%s" 'face 'font-lock-string-face) "\n"
	      (propertize "フォントサイズ:" 'face 'font-lock-function-name-face) "\t" (propertize "%s" 'face 'font-lock-string-face))
	     ascii kana kanji sz)))

