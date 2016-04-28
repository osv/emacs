;; this version of emacs my setup used for `emacs -nw -q'
(add-to-list 'load-path "~/emacs/external")

(load "~/emacs/rc/core-packages.el")
;; (load "~/emacs/rc/core-ui.el")
;; (load "~/emacs/rc/core-lang.el")
;; (load "~/emacs/rc/core-desktop.el")
 (load "~/emacs/rc/company-completion.el")
;; (load "~/emacs/rc/helm.el")
 (load "~/emacs/pmade/emacs.d/pmade-colors.el")

(add-to-list 'auto-mode-alist '("git-rebase-todo" . conf-mode))
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . conf-mode))
