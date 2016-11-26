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
(add-to-list 'auto-mode-alist '("\\.tt\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tag\\'" . web-mode))
(add-to-list 'auto-mode-alist
             '("/\\(views\\|html\\|theme\\|templates\\)/.*\\.php\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

(setq web-mode-engines-alist
      '(("mojolicious" . "\\.html.ep")
        ("angular" . "\\.html")))

(add-to-list 'web-mode-engine-attr-regexps
             '("ctemplate"   . "data-"))
(add-to-list 'web-mode-engine-attr-regexps
             '("angular"   . "data-")
             '("angular"   . "ng-"))

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
  (sp-local-tag "=" "<%= " " %>")
  (sp-local-tag "#" "<%# " " %>"))

(define-key web-mode-map (kbd "C-c C-v") 'browse-url-of-buffer)


(setq-default
 ;; web-mode-enable-auto-pairing t
 ;; web-mode-enable-auto-opening t
 ;; web-mode-enable-auto-indentation t
 web-mode-enable-block-face t
 web-mode-enable-part-face t
 web-mode-enable-comment-keywords t
 ;; web-mode-enable-css-colorization t
 web-mode-enable-current-element-highlight t
 ;; web-mode-enable-heredoc-fontification t
 ;; web-mode-enable-engine-detection t

 ;; web-mode-markup-indent-offset 2
 ;; web-mode-css-indent-offset 2
 ;; web-mode-code-indent-offset 2

 ;; web-mode-style-padding 2
 ;; web-mode-script-padding 2
 ;; web-mode-block-padding 0
 ;; web-mode-comment-style 2
 )

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
  "Hook for `web-mode'."
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
  (emmet-mode t)
  (set (make-local-variable 'company-backends)
       '(company-tern company-web-html company-yasnippet company-files))
  (setq web-mode-enable-auto-quoting nil))

;; maybe in future add this
;; (add-to-list 'web-mode-ac-sources-alist '("html" . (ac-source-jquery-event-dict ac-source-jquery-callback-dict ac-source-jquery-deferred-dict ac-source-jquery-selector-dict)))

(add-hook 'web-mode-hook 'my-web-mode-hook)

;; Enable JavaScript completion between <script>...</script> etc.
(defadvice company-tern (before web-mode-set-up-ac-sources activate)
  "Set `tern-mode' based on current language before running company-tern."
  (message "advice")
  (if (equal major-mode 'web-mode)
      (let ((web-mode-cur-language
             (web-mode-language-at-pos)))
        (if (or (string= web-mode-cur-language "javascript")
                (string= web-mode-cur-language "jsx")
                )
            (unless tern-mode (tern-mode))
          (if tern-mode (tern-mode -1))))))


;; manual autocomplete
(define-key web-mode-map (kbd "M-SPC") 'company-complete)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CSS

(add-hook  'css-mode-hook
           (lambda ()
             (flycheck-mode +1)
             (rainbow-mode +1)))

(add-hook  'less-mode-hook
           (lambda ()
             (flycheck-mode +1)
             (rainbow-mode +1)))

(css-eldoc-enable)

(defun css-complete-hook ()
  (local-set-key (kbd "M-SPC") 'company-css)
  (set (make-local-variable 'company-backends)
       '(company-css company-yasnippet company-files)))

(add-hook  'less-mode-hook 'css-complete-hook)
(add-hook  'scss-mode-hook 'css-complete-hook)
;; cool selector
;; `helm-css-scss-multi' use it to select

(require 'helm-css-scss)

(add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode))
(add-hook 'restclient-mode (lambda ()
                             (set (make-local-variable 'company-backends) '(company-restclient company-files))))
