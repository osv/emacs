;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c c l") 'org-store-link)
(global-set-key (kbd "C-c c a") 'org-agenda)
(setq org-agenda-files (list "~/org/work.org"
			     "~/org/date.org"
 			     "~/org/home.org"))
;;(setq org-agenda-files (find-lisp-find-files "~/org" "\.org"))
(setq org-log-done t)

(setq org-agenda-custom-commands
      '(("e" tags-todo "emacs" nil)
        ("w" tags-todo "Write/TODO" nil)
        ("c" tags-todo "Read/CANCELLED" nil)
        ("R" tags-todo "Read/NEXT|TODO" nil)
        ("W" tags-todo "Write/NEXT|INPROGRESS" nil)))

(defun my-org-agenda-hook ()
  (local-set-key "\C-cd" 'org-agenda-toggle-diary)
  )
(add-hook 'org-agenda-mode-hook 'my-org-agenda-hook)

(add-hook 'org-agenda-mode-hook '(lambda () (hl-line-mode 1)))

(setq org-agenda-include-diary t)

;; And in my BBDB setup:
;; (require 'bbdb-anniv)
;; (add-hook 'diary-list-entries-hook 'bbdb-anniv-diary-entries)

;;(global-set-key "\C-ql" 'org-store-link)
;;(global-set-key "\C-qa" 'org-agenda)
;;(global-set-key "\C-qb" 'org-iswitchb)
