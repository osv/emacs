;; `C-c C-v' browse url
;; install: npm install -g csslint

(require 'web-beautify)

;;(add-to-list 'load-path "~/work/github/ac-html-bootstrap")
;; (add-to-list 'load-path "~/work/github/web-completion-data")
;; (add-to-list 'load-path "~/work/github/company-html")

;; some complex web mode
(require 'web-mode)

(require 'company-web)
(require 'company-web-html)
(require 'company-web-jade)
(require 'company-web-slim)

;; extend company-web
(require 'ac-html-bootstrap)
(require 'ac-html-csswatcher)
(company-web-csswatcher-setup)

;; hooks for jade&slim, activate company
(add-hook 'jade-mode-hook (lambda ()
                              (set (make-local-variable 'company-backends) '(company-web-jade company-files))))

(add-hook 'slim-mode-hook (lambda ()
                              (set (make-local-variable 'company-backends) '(company-web-slim company-files))))


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

(defun my-web-mode-hook ()
  "Hook for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-ac-sources-alist
        '(("css" . (
                    ac-source-css-property
                    ac-source-dictionary
                    ac-source-words-in-same-mode-buffers
                  ))
          ("html" . (
		     ac-source-html-attribute-value
                     ac-source-html-tag
                     ac-source-html-attribute
		     ac-source-filename
                     ac-source-yasnippet
                     ))))
  (set (make-local-variable 'company-backends) '(company-web-html company-yasnippet company-files))
  (setq web-mode-enable-auto-quoting nil))

;; maybe in future add this
;; (add-to-list 'web-mode-ac-sources-alist '("html" . (ac-source-jquery-event-dict ac-source-jquery-callback-dict ac-source-jquery-deferred-dict ac-source-jquery-selector-dict)))

(add-hook 'web-mode-hook 'my-web-mode-hook)


;; manual js autocomplete
(define-key web-mode-map (kbd "M-SPC") 'company-web-html)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CSS

(add-hook  'css-mode-hook
           (lambda ()
             (rainbow-mode +1)))

(css-eldoc-enable)

;; cool selector
;; `helm-css-scss-multi' use it to select

(require 'helm-css-scss)

