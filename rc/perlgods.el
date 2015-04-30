;; install: cpan Devel::PerlySense Emacs::PDE
;; install: cpan Devel::CoverX::Covered
;; install: # https://github.com/aki2o/plsense
;;
;; PDE:
;; `perldoc'
;; `woman'
;; `inf-perl-start' and `inf-perl-send'
;; C-c C-v RET     pde-pod-to-manpage
;;
;; PerlySense:
;; first:
;;
;;     perly_sense process_project
;;
;; provide:
;; `C-o g u'   goto use
;; `C-o g n'   goto new
;; `C-o g m'   goto module at point
;; `C-o e e v' `lr-extract-variable'
;; `C-o a r'   regexp
;; `C-o g t o' goto test, if covered only
;; `C-o r c' run coverage
;;  plcmp:
;; [C-c C-c a] plcmp-cmd-complete-all
;;

(add-to-list 'auto-mode-alist '("\\.t\\'" . cperl-mode))

;; (defun my-perl-cfg ()
;;   (flycheck-mode t))
;; (add-hook 'cperl-mode-hook 'my-perl-cfg)

(add-hook 'cperl-mode-hook 'flycheck-mode t)
(add-hook 'cperl-mode-hook 'idle-highlight-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PDE
(add-to-list 'load-path "~/emacs/external/pde/")
(setq pde-extra-setting nil)
(load "pde-load")

;; (global-set-key (kbd "M-'") 'just-one-space)
;; (global-set-key (kbd "C-M-=") 'pde-indent-dwim)
;; ;; nearest key to dabbrev-expand
;; (global-set-key (kbd "C-;") 'hippie-expand)
;; (global-set-key "\C-cs" 'compile-dwim-compile)
;; (global-set-key "\C-cr" 'compile-dwim-run)

;; end of PDE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (require 'complete)           ; need for define PC-include-file-path
;; (partial-completion-mode t)
;; (setq PC-include-file-path
;;       (append PC-include-file-path pde-perl-inc))
;; (setq imenu-tree-auto-update t)
;; (setq compilation-buffer-name-function 'pde-compilation-buffer-name)
;; (add-hook 'perldoc-mode-hook 'pde-tabbar-register)
;; (autoload 'comint-dynamic-complete "comint" "Complete for file name" t)
;; (autoload 're-builder "re-builder-x" "Construct a regexp interactively." t)
;; (setq comint-completion-addsuffix '("/" . ""))
;; (setq tags-table-list '("./TAGS" "../TAGS" "../../TAGS"))
;; (setq hippie-expand-try-functions-list
;;       '(try-expand-line
;;         try-expand-dabbrev
;;         try-expand-line-all-buffers
;;         try-expand-list
;;         try-expand-list-all-buffers
;;         try-expand-dabbrev-visible
;;         try-expand-dabbrev-all-buffers
;;         try-expand-dabbrev-from-kill
;;         try-complete-file-name
;;         try-complete-file-name-partially
;;         try-complete-lisp-symbol
;;         try-complete-lisp-symbol-partially
;;         try-expand-whole-kill))



;; *** PerlySense Config ***
;; ** PerlySense **
;; The PerlySense prefix key (unset only if needed, like for \C-o)
(global-unset-key "\C-o")
(setq ps/key-prefix "\C-o")


;; ** Flymake **
;; Load flymake if t
;; Flymake must be installed.
;; It is included in Emacs 22
;;     (or http://flymake.sourceforge.net/, put flymake.el in your load-path)
(setq ps/load-flymake t)
;; Note: more flymake config below, after loading PerlySense


;; *** PerlySense load (don't touch) ***
(setq ps/external-dir (shell-command-to-string "perly_sense external_dir"))
(if (string-match "Devel.PerlySense.external" ps/external-dir)
    (progn
      (message
       "PerlySense elisp files  at (%s) according to perly_sense, loading..."
       ps/external-dir)
      (setq load-path (cons
		       (expand-file-name
			(format "%s/%s" ps/external-dir "emacs")
			) load-path))
      (load "perly-sense")
      )
  (message "Could not identify PerlySense install dir.
    Is Devel::PerlySense installed properly?
    Does 'perly_sense external_dir' give you a proper directory? (%s)" ps/external-dir)
  )

;; ** Code Coverage Visualization **
;; If you have a Devel::CoverX::Covered database handy and want to
;; display the sub coverage in the source, set this to t
(setq ps/enable-test-coverage-visualization nil)

;; ** Misc Config **

;; Run calls to perly_sense as a prepared shell command. Experimental
;; optimization, please try it out.
(setq ps/use-prepare-shell-command t)

;; *** PerlySense End ***
;;;;;;;

;; perl-completion-mode
;; (add-hook 'cperl-mode-hook
;;           (lambda()
;;             (require 'perl-completion)
;;             (perl-completion-mode t)))
;; (add-hook  'cperl-mode-hook
;;            (lambda ()
;;              (when (require 'auto-complete nil t) ; no error whatever auto-complete.el is not installed.
;;                (auto-complete-mode t)
;;                (make-variable-buffer-local 'ac-sources)
;;                (setq ac-sources
;;                      '(ac-source-perl-completion)))))

;; my face for `lr-extract-variable'
(setq lr-extract-variable-face
      '(:background "RoyalBlue"))

;; Highlight Catalyst/DBIC setup code, add this
;; -
;;    moniker: "Package method calls (Cat/DBIC)"
;;    rex:
;;      - qr/ __PACKAGE__ \s* -> \s* ( [\w]+ .* ) /x
;; end


;; ;; Key binding
;; (require 'plsense)
;; (setq plsense-popup-help-key "C-:")
;; (setq plsense-display-help-buffer-key "M-:")
;; (setq plsense-jump-to-definition-key "C->")
;; (plsense-config-default)

(setq load-path (cons  "~/emacs/external/perl-completion" load-path))

(require 'perl-completion)
(add-hook  'cperl-mode-hook
           (lambda ()
             (perl-completion-mode t)
             (auto-complete-mode t)
             (make-variable-buffer-local 'ac-sources)
             (setq ac-sources
                   '(ac-source-perl-completion ac-source-words-in-same-mode-buffers ac-source-filename))))

(defface ac-plcmp-candidate-face
  '((t (:background "#5B929A" :foreground "#eee")))
  "Face for HTML tag candidate."
  :group 'auto-complete)

(setq ac-source-perl-completion
      (append
       '(
         (candidate-face . ac-plcmp-candidate-face)
         (selection-face . ac-my-selection-face)
         ;;(requires . 0)
         (symbol . "P")
         ) ac-source-perl-completion))


(setq ac-source-perl-completion-patial
      (append
       '(
         (candidate-face . ac-plcmp-candidate-face)
         (selection-face . ac-my-selection-face)       
         (symbol . "p")
         ) ac-source-perl-completion-patial))

(define-key cperl-mode-map (kbd "C-c t") 'perltidy-region)
