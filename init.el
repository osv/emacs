;; Make sure all these files is in ~/emacs folder
;;
;; Add to you ~/.emacs.el
;; (load "~/emacs/init.el")


(add-to-list 'load-path "~/emacs/external")

(load "~/emacs/rc/core-packages.el")

(load "~/emacs/rc/core-ui.el")
(load "~/emacs/rc/core-lang.el")
(load "~/emacs/rc/core-desktop.el")

(when (display-graphic-p)
 (load "~/emacs/rc/core-fonts.el"))

(load "~/emacs/rc/ac-autocomplete.el")
(load "~/emacs/rc/company-completion.el")
(load "~/emacs/rc/helm.el")

(load "~/emacs/rc/assoc.el")
(load "~/emacs/rc/cmode.el")
(load "~/emacs/rc/coffee.el")
(load "~/emacs/rc/smartparens.el")

(load "~/emacs/rc/minimap.el")
(when (display-graphic-p)
  (load "~/emacs/rc/mingus.el"))

(load "~/emacs/rc/js.el")
(load "~/emacs/rc/web.el")

(load "~/emacs/rc/jabber.el")
(load "~/emacs/rc/perlgods.el")
