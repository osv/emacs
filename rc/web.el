;; `C-c C-v' browse url
;; install: npm install -g csslint

(require 'web-beautify)

;; some complex web mode
(require 'web-mode)

(require 'ac-html)
(require 'ac-jade)
(require 'ac-haml)
(require 'ac-slim)
(require 'ac-html-bootstrap)
(require 'ac-html-csswatcher)

(ac-html-csswatcher-setup)

(add-hook 'jade-mode-hook 'ac-jade-enable)
(add-hook 'haml-mode-hook 'ac-haml-enable)
(add-hook 'html-mode-hook 'ac-html-enable)
(add-hook 'slim-mode-hook 'ac-slim-enable)

;; extend web mode

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist
             '("/\\(views\\|html\\|theme\\|templates\\)/.*\\.php\\'" . web-mode))

(setq web-mode-engines-alist
      '(("mojolicious" . "\\.html.ep")
        ("ctemplate" . "\\.html")))

(add-to-list 'web-mode-engine-attr-regexps
             '("ctemplate"   . "data-"))

;; make web-mode play nice with smartparens
(setq web-mode-enable-auto-pairing nil)
(sp-with-modes '(web-mode)
  (sp-local-pair "%" "%"
                 :unless '(sp-in-string-p)
                 :post-handlers '(((lambda (&rest _ignored)
                                     (just-one-space)
                                     (save-excursion (insert " ")))
                                   "SPC" "=" "#")))
  (sp-local-pair "<% " " %>" :insert "C-c %")
  (sp-local-pair "<%= " " %>" :insert "C-c =")
  (sp-local-pair "<%# " " %>" :insert "C-c #")
  (sp-local-tag "%" "<% " " %>")
  (sp-local-tag "=" "<%= " " %>")
  (sp-local-tag "#" "<%# " " %>"))

(define-key web-mode-map (kbd "C-c C-v") 'browse-url-of-buffer)

(setq web-mode-enable-comment-keywords t)
(setq web-mode-enable-block-face 't)
(setq web-mode-enable-part-face t)

;; http://blog.binchen.org/posts/how-to-use-flyspell-in-web-mode.html
(defun web-mode-flyspefll-verify ()
  (let ((f (get-text-property (- (point) 1) 'face)))
    (not (memq f '(web-mode-html-attr-value-face
                   web-mode-html-tag-face
                   web-mode-html-attr-name-face
                   web-mode-doctype-face
                   web-mode-keyword-face
                   web-mode-function-name-face
                   web-mode-variable-name-face
                   web-mode-css-property-name-face
                   web-mode-css-selector-face
                   web-mode-css-color-face
                   web-mode-type-face
                   )
               ))))
(put 'web-mode 'flyspell-mode-predicate 'web-mode-flyspefll-verify)

(require 'tern-auto-complete)

(defun my-web-mode-hook ()
  "Hook for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-ac-sources-alist
        '(("css" . (
                    ac-source-css-property
                    ac-source-dictionary
                    ;; ac-source-emmet-css-snippets
                    ac-source-words-in-same-mode-buffers
                  ))
          ("html" . (
                     ac-source-tern-completion
		     ac-source-html-attribute-value
                     ac-source-html-tag
                     ac-source-html-attribute
		     ac-source-filename
                     ;; ac-source-dictionary
                     ;; ac-source-abbrev
                     ;; ac-source-gtags
		     ;; ac-source-emmet-html-aliases ac-source-emmet-html-snippets
                     ;; ac-source-words-in-same-mode-buffers
                     ac-source-yasnippet
                     ))
          ("jsx" . (
                     ac-source-tern-completion))
          ("javascript" . (
                     ac-source-tern-completion))))
  (set (make-local-variable 'company-backends) '(company-css company-files))
  (setq web-mode-enable-auto-quoting nil)
  (auto-complete-mode 1)
  ;; (lambda ()
  ;;   (when (equal web-mode-content-type "javascript")
  ;;     ;; enable flycheck
  ;;     (flycheck-select-checker 'my-javascript-jshint)
  ;;     (flycheck-mode)))
  (auto-complete-mode t)
  (tern-mode t))

;; maybe in future add this
;; (add-to-list 'web-mode-ac-sources-alist '("html" . (ac-source-jquery-event-dict ac-source-jquery-callback-dict ac-source-jquery-deferred-dict ac-source-jquery-selector-dict)))

(add-hook 'web-mode-hook 'my-web-mode-hook)


;; manual autocomplete
(define-key web-mode-map (kbd "M-SPC") 'tern-ac-complete)


;; other face customize

;; (setq ac-source-haml-tag
;;       (append
;;        '(
;;          (candidate-face . ac-html-tag-face)
;;          (selection-face . ac-my-selection-face)
;;          (requires . 0)
;;          ) ac-source-haml-tag))

;; (setq ac-source-haml-attribute
;;       (append
;;        '(
;;          (candidate-face . ac-html-attribute-face)
;;          (selection-face . ac-my-selection-face)
;;          (requires . 0)
;;          ) ac-source-haml-attribute))

;; (setq ac-source-haml-attribute-value
;;       (append
;;        '(
;;          (candidate-face . ac-html-selection-face)
;;          (selection-face . ac-my-selection-face)
;;          (requires . 0)
;;          ) ac-source-haml-attribute-value))

;; (setq ac-source-jade-tag
;;       (append
;;        '(
;;          (candidate-face . ac-html-tag-face)
;;          (selection-face . ac-my-selection-face)
;;          (requires . 0)
;;          ) ac-source-jade-tag))

;; (setq ac-source-jade-attribute
;;       (append
;;        '(
;;          (candidate-face . ac-html-attribute-face)
;;          (selection-face . ac-my-selection-face)
;;          (requires . 0)
;;          ) ac-source-jade-attribute))

;; (setq ac-source-jade-attribute-value
;;       (append
;;        '(
;;          (candidate-face . ac-html-selection-face)
;;          (selection-face . ac-my-selection-face)
;;          (requires . 0)
;;          ) ac-source-jade-attribute-value))



;; (setq ac-source-slim-tag
;;       (append
;;        '(
;;          (candidate-face . ac-html-tag-face)
;;          (selection-face . ac-my-selection-face)
;;          (requires . 0)
;;          ) ac-source-slim-tag))

;; (setq ac-source-slim-attribute
;;       (append
;;        '(
;;          (candidate-face . ac-html-attribute-face)
;;          (selection-face . ac-my-selection-face)
;;          (requires . 0)
;;          ) ac-source-slim-attribute))

;; (setq ac-source-slim-attribute-value
;;       (append
;;        '(
;;          (candidate-face . ac-html-selection-face)
;;          (selection-face . ac-my-selection-face)
;;          (requires . 0)
;;          ) ac-source-slim-attribute-value))

;; CSS

(add-hook  'css-mode-hook
           (lambda ()
             (rainbow-mode +1)
             (auto-complete-mode t)))

(css-eldoc-enable)

;; cool selector
;; `helm-css-scss-multi' use it to select

(require 'helm-css-scss)

