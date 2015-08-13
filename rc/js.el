;; install: npm install -g jshint
;; install: npm install -g swank-js
;; install: https://raw.githubusercontent.com/Slava/tern-meteor/master/meteor.js > 
;; use `skewer-mode' for interact

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es7$" . js2-mode))

(add-to-list 'auto-mode-alist (cons (regexp-opt '(".tern-project"
                                              ".bowerrc"
                                              ".eslintrc"
                                              ".babelrc"
                                              ".jshintrc"
                                              ".json"))
                                    'json-mode))

(require 'discover-js2-refactor)
(require 'js2-mode)
(require 'json-mode)
(require 'tern)
;JS settings start

(setq js-basic-indent 2)
(setq-default js2-basic-indent 2)

(setq-default js2-basic-offset 2)
(setq-default js2-auto-indent-p t)
(setq-default js2-cleanup-whitespace t)
(setq-default js2-enter-indents-newline t)
(setq-default js2-global-externs "jQuery $")
(setq-default js2-indent-on-enter-key t)
(setq-default js2-mode-indent-ignore-first-tab t)

(setq-default js2-global-externs '("module" "require" "buster" "sinon" "assert"
                                   "refute" "setTimeout" "clearTimeout" "setInterval"
                                   "clearInterval" "location" "__dirname"
                                   "console" "JSON"))

;; We'll let fly do the error parsing...
(setq-default js2-mode-show-parse-errors nil)
(setq-default js2-strict-trailing-comma-warning nil)
(setq-default js2-strict-missing-semi-warning nil)

;; ;make the word function in to just f
;; (font-lock-add-keywords
;;  'js2-mode `(("\\(function *\\)("
;;              (0 (progn (compose-region (match-beginning 1) (match-end 1) "ƒ")
;;                        nil)))))

;place warning font around TODO and others
(font-lock-add-keywords 'js2-mode
                        '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
                           1 font-lock-warning-face t)))

(add-hook 'js2-mode-hook
          (lambda () (flycheck-mode t)))

(add-hook 'json-mode-hook
          (lambda () (flycheck-mode t)))

;; better use tern
;; ;; M-/ complete
;; ;; M-. goto definition
;; (add-hook 'js2-mode-hook 'ac-js2-mode)

;; install: npm install -g tern
(add-hook 'js2-mode-hook
            (lambda ()
              (tern-mode)
              (set (make-local-variable 'company-backends) '(company-tern company-files company-yasnippet))))
(define-key js2-mode-map (kbd "M-SPC") 'company-tern)
(define-key js2-mode-map (kbd "RET") 'js2-line-break) ; I use ret for line break, not M-j
(define-key js2-mode-map (kbd "C-c j") 'tern-find-definition)
(define-key js2-mode-map (kbd "C-c t") 'web-beautify-js)
(define-key json-mode-map (kbd "C-c t") 'json-reformat-region)
;; C-c C-r - refactor

;;(setq ac-js2-evaluate-calls t)
;(add-to-list 'ac-js2-external-libraries "path/to/lib/library.js")

;; (add-to-list 'load-path "~/emacs/js2-refactor.el/")
;; (require 'js2-refactor)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))
