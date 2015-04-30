(defun toggle-japanse-input-method ()
  "toggle between japanese and no input method"
  (interactive)
  (if (string= current-input-method "japanese")
      (set-input-method nil)
    (set-input-method "japanese")))

(defun toggle-japanse-katakana-input-method ()
  "toggle between japanese and no input method"
  (interactive)
  (if (string= current-input-method "japanese-katakana")
      (set-input-method nil)
    (set-input-method "japanese-katakana")))

(defun toggle-russian-input-method ()
  "toggle between ru and no input method"
  (interactive)
  (if (string= current-input-method "russian-computer")
      (set-input-method nil)
    (set-input-method "russian-computer")))

(defun toggle-ukrainian-input-method ()
  "toggle between ua and no input method"
  (interactive)
  (if (string= current-input-method "ukrainian-computer")
      (set-input-method nil)
    (set-input-method "ukrainian-computer")))

(defun toggle-esperanto-input-method ()
  "toggle between esperanto and no input method"
  (interactive)
  (if (string= current-input-method "esperanto-postfix")
      (set-input-method nil)
    (set-input-method "esperanto-postfix")))

(global-set-key (kbd "C-x RET j") 'toggle-japanse-input-method)
(global-set-key (kbd "C-x RET s") 'toggle-russian-input-method)
(global-set-key (kbd "C-x RET u") 'toggle-ukrainian-input-method) 
(global-set-key (kbd "C-x RET o") 'toggle-esperanto-input-method) 
(global-set-key (kbd "C-x RET k") 'toggle-japanse-katakana-input-method)

;; install apt-get install hunspell hunspell-ru
;; install http://sourceforge.net/projects/ispell-uk/files/spell-uk/
(require 'ispell)
;;(add-to-list 'exec-path "/usr/local/bin")

(setq ispell-local-dictionary-alist
      '((nil ; default
         "[A-Za-z]" "[^A-Za-z]" "[']" t
         ("-d" "en_US" "-i" "utf-8") nil utf-8)
	("hunspell-en-ru"                   ; combo english+russian
         "[a-zA-ZАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
         "[^a-zA-ZАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюя]"
         "[-']"
         nil ("-d" "en_US,ru_RU") nil utf-8)
        ("hunspell-en-uk"                   ; combo english+ukrainian
         "[a-zA-ZАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюяіїєґ]"
         "[^a-zA-ZАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯабвгдеёжзийклмнопрстуфхцчшщьыъэюяіїєґ]"
         "[-']"
         nil ("-d" "en_US,uk_UA") nil utf-8)))


(setq ispell-really-aspell nil)
(setq ispell-really-hunspell t)

(setq ispell-dictionary "hunspell-en-ru")
(setq ispell-program-name "hunspell")

(add-hook 'org-mode-hook
  (lambda()
    (flyspell-mode)))

(add-hook 'markdown-mode-hook
  (lambda()
    (flyspell-mode)))

