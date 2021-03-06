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

(font-lock-add-keywords 'js2-mode
                        '(("\\<\\(FIX\\|TODO\\|FIXME\\|HACK\\|REFACTOR\\):"
                           1 font-lock-warning-face t)))

(add-hook 'js2-mode-hook
          (lambda ()
            (digit-groups-mode t)
            (flycheck-mode t)))

(add-hook 'json-mode-hook
          (lambda ()
            (digit-groups-mode t)
            (flycheck-mode t)))

;; better use tern
;; ;; M-/ complete
;; ;; M-. goto definition
;; (add-hook 'js2-mode-hook 'ac-js2-mode)

;; install: npm install -g tern
(add-hook 'js2-mode-hook
            (lambda ()
              (tern-mode)
              (idle-highlight-mode t)
              (set (make-local-variable 'company-backends) '(company-tern company-files company-yasnippet))))
(define-key js2-mode-map (kbd "M-SPC") 'company-tern)
(define-key js2-mode-map (kbd "C-;") 'company-flow)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; From https://github.com/startup-class/dotfiles/blob/master/.emacs.d/js-config.el

;; Configure jshint for JS style checking.
;;   - Install: $ npm install -g jshint
;;   - Usage: Hit C-cC-u within any emacs buffer visiting a .js file
(setq jshint-cli "jshint --show-non-errors ")
(setq compilation-error-regexp-alist-alist
      (cons '(jshint-cli "^\\([a-zA-Z\.0-9_/-]+\\): line \\([0-9]+\\), col \\([0-9]+\\)"
                         1 ;; file
                         2 ;; line
                         3 ;; column
                         )
            compilation-error-regexp-alist-alist))
(setq compilation-error-regexp-alist
      (cons 'jshint-cli compilation-error-regexp-alist))

;; TypeScript
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; ;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; format options
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

(defun node-repl-comint-preoutput-filter (output)
  "This function fixes the escape issue with node-repl in js-comint.el.
  Heavily adapted from http://www.squidoo.com/emacs-comint (which
  is in emacs/misc/comint_ticker)
  Basically, by adding this preoutput filter to the
  comint-preoutput-filter-functions list we take the output of
  comint in a *js* buffer and do a find/replace to replace the
  ANSI escape noise with a reasonable prompt.
"
  (if (equal (buffer-name) "*js*")
      (progn
        ;; Uncomment these to debug the IO of the node process
        ;; (setq js-node-output output)
        ;; (message (concat "\n----------\n" output "\n----------\n"))

        ;; Replaced ^ with \^ to indicate that doesn't have to be
        ;; at start of line
        (replace-regexp-in-string
         "\\\[0K" ""
         (replace-regexp-in-string
          "\\\[1G" ""
          (replace-regexp-in-string
           "\\\[0J" ""
           (replace-regexp-in-string
            "\\\[3G" ""
            (replace-regexp-in-string
             "\\\[0G" ""
             (replace-regexp-in-string
              "\\[2C" ""
              (replace-regexp-in-string
               "\\[0K" ""
               (replace-regexp-in-string
                "
" "" output))))))))
        )
    output
    )
  )

(add-hook 'comint-preoutput-filter-functions 'node-repl-comint-preoutput-filter)
(add-hook 'comint-output-filter-functions 'node-repl-comint-preoutput-filter)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
