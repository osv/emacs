(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(global-set-key (kbd "C-c /") 'company-files)
(global-set-key (kbd "C-c ?") 'company-ispell)
(global-set-key (kbd "C-c '") 'company-dict)
(global-set-key (kbd "C-c M-SPC") 'company-try-hard)

;;(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-tooltip-align-annotations 't)          ; align annotations to the right tooltip border
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

(eval-after-load 'company
  '(progn
     (define-key company-mode-map (kbd "C-'") 'helm-company)
     (define-key company-active-map (kbd "C-'") 'helm-company)))

;; Sort completion candidates by previous completion choices
(add-hook 'after-init-hook 'company-statistics-mode)

(setq company-dabbrev-downcase 'nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; company-shell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'company-backends 'company-shell)

(add-to-list 'company-backends 'company-elisp)

;; Where to look for dictionary files. Default is ~/.emacs.d/dict
(setq company-dict-dir "~/emacs/dicts/company-dict")

;; Optional: if you want it available anywhere
(add-to-list 'company-backends 'company-dict)
