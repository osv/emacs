(require 'auto-complete-config)
(ac-config-default)

;; (global-auto-complete-mode t)

(setq ac-use-menu-map t        ; Move selective candidates by [C-n] / [C-p]
      ac-use-quick-help t      ; use quick help
      ac-auto-show-menu 0.3    ; Popup candidates delay
      ac-quick-help-delay 0.5)

(define-key ac-completing-map (kbd "C-g") 'ac-stop)

;; Each mode have own dictionaryies
(add-to-list 'ac-dictionary-directories "~/emacs/dicts/ac-mode-dict/")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;-----------
;; Auto-Complete user dictionaries location.
(defvar ac-user-dict-dir (expand-file-name "~/emacs/dicts/ac-user-dict/"))

;; Currently selected candidate's color setting.
(defface ac-my-selection-face
  '((t (:background "#000080" :foreground "#ffffff")))
  "Face for selectied candidate."
  :group 'auto-complete)

;; Complete action:
;; Put the cursor within () if a candidate has () at the end of it.
(defun ac-go-into-braces-action ()
  (save-restriction
    (narrow-to-region (point) (- (point) 2))
    (if (re-search-backward "()" nil t)
        (forward-char))))

;; Prefix Condition:
;; Auto completion start after any single character + dot(.) context.
(defun ac-js-dot-prefix ()
  "`x.' prefix."
  (if (re-search-backward ".\\.\\(.*\\)" nil t)
      (match-beginning 1)))

;;; Dictionary 1 (underscore.js)
;; Color setting.
(defface ac-underscore-js-candidate-face
  '((t (:background "#730CE8" :foreground "#eeeeee")))
  "Face for underscore.js candidate."
  :group 'auto-complete)
;; Specify a dictionary as candidates.
(defvar ac-underscore-js-cache
  (ac-file-dictionary (concat ac-user-dict-dir "underscore-js")))
;; Dictionary 1 settings.
(defvar ac-source-underscore-js-dict
  '(
    ;; Required. Below lines are optional.
    (candidates . ac-underscore-js-cache)
    ;; Override `ac-candidate-face' partially.
    (candidate-face . ac-underscore-js-candidate-face)
    ;; Override `ac-selection-face' partially.
    (selection-face . ac-my-selection-face)
    ;; Prefix condition.
    (prefix . ac-js-dot-prefix)
    ;; Predefined actions after completion.
    (action . ac-go-into-braces-action)
    ;; Library name, attribute etc. (It works even if not character.)
    (symbol . "underscore.js")
    ;; Override `ac-auto-start' partially.
    ;; (requires . 2)
    ;; Override `ac-candidate-limit' partially.
    ;; (limit . 30)
    ))

;;; Dictionary 2 (jQuery)
(defface ac-jquery-candidate-face
  '((t (:background "#1f679a" :foreground "#eeeeee")))
  "Face for jquery candidate."
  :group 'auto-complete)

(defvar ac-jquery-method1-cache
  (ac-file-dictionary (concat ac-user-dict-dir "jquery-method1")))

(defvar ac-source-jquery-method-dict1
  '((candidates . ac-jquery-method1-cache)
    (candidate-face . ac-jquery-candidate-face)
    (selection-face . ac-my-selection-face)
    (prefix . ac-js-dot-prefix)
    (action . ac-go-into-braces-action)
    (symbol . "jquery method1")))

;;; Dictionary 3 (jQuery prefix `jQuery.' or `$.')
(defun ac-jquery-method2-prefix ()
  "`$' or `jQuery' prefix."
  (if (re-search-backward "\\(jQuery\\|\\$\\)\\.\\(.*\\)" nil t)
      (match-beginning 2)))

(defvar ac-jquery-method2-cache
  (ac-file-dictionary (concat ac-user-dict-dir "jquery-method2")))

(defvar ac-source-jquery-method-dict2
  '((candidates . ac-jquery-method2-cache)
    (candidate-face . ac-jquery-candidate-face)
    (selection-face . ac-my-selection-face)
    (prefix . ac-jquery-method2-prefix)
    (action . ac-go-into-braces-action)
    (symbol . "jquery method2")))

;;; Dictionary 4 (jQuery selector prefix `x:')
(defun ac-jquery-selector-prefix ()
  "`x:' prefix."
  (if (re-search-backward ".\\:\\(.*\\)" nil t)
      (match-beginning 1)))

(defface ac-jquery-selector-candidate-face
  '((t (:background "#1B919A" :foreground "#eeeeee")))
  "Face for jquery selector candidate."
  :group 'auto-complete)

(defvar ac-jquery-selector-cache
  (ac-file-dictionary (concat ac-user-dict-dir "jquery-selector")))

(defvar ac-source-jquery-selector-dict
  '((candidates . ac-jquery-selector-cache)
    (candidate-face . ac-jquery-selector-candidate-face)
    (selection-face . ac-my-selection-face)
    (prefix . ac-jquery-selector-prefix)
    (action . ac-go-into-braces-action)
    (symbol . "jQuery selector")))

;;; Dictionary 5 (jQuery deferred)
(defvar ac-jquery-deferred-cache
  (ac-file-dictionary (concat ac-user-dict-dir "jquery-deferred")))

(defvar ac-source-jquery-deferred-dict
  '((candidates . ac-jquery-deferred-cache)
    (candidate-face . ac-jquery-candidate-face)
    (selection-face . ac-my-selection-face)
    (prefix . ac-js-dot-prefix)
    (action . ac-go-into-braces-action)
    (symbol . "jQuery deferred")))

;;; Dictionary 6 (jQuery callback)
(defvar ac-jquery-callback-cache
  (ac-file-dictionary (concat ac-user-dict-dir "jquery-callback")))

(defvar ac-source-jquery-callback-dict
  '((candidates . ac-jquery-callback-cache)
    (candidate-face . ac-jquery-candidate-face)
    (selection-face . ac-my-selection-face)
    (prefix . ac-js-dot-prefix)
    (action . ac-go-into-braces-action)
    (symbol . "jQuery callback")))

;;; Dictionary 7 (jQuery event)
(defvar ac-jquery-event-cache
  (ac-file-dictionary (concat ac-user-dict-dir "jquery-event")))

(defvar ac-source-jquery-event-dict
  '((candidates . ac-jquery-event-cache)
    (candidate-face . ac-jquery-candidate-face)
    (selection-face . ac-my-selection-face)
    (prefix . ac-js-dot-prefix)
    (action . ac-go-into-braces-action)
    (symbol . "jQuery event")))

;; dictionaries and sorces for jquery and underscore.js.
(defun ac-js-mode-setup ()
  (setq ac-sources (append '(
                             ac-source-jquery-method-dict2  ; prefix `$.'
                             ac-source-jquery-method-dict1  ; prefix `x.'
                             ac-source-underscore-js-dict   ; prefix `x.'
                             ac-source-jquery-deferred-dict ; prefix `x.'
                             ac-source-jquery-callback-dict ; prefix `x.'
                             ac-source-jquery-event-dict    ; prefix `x.'
                             ac-source-jquery-selector-dict ; prefix `x:'
                             ) ac-sources)))

;; ;; Apply to each major mode.
;;  (add-hook 'js-mode-hook 'ac-js-mode-setup)
;;  (add-hook 'js2-mode-hook 'ac-js-mode-setup)
;;  (add-hook 'web-mode-hook 'ac-js-mode-setup)

(defface ac-dictionary-candidate-face
  '((t (:background "#03714A" :foreground "#eeeeee")))
  "Face for jquery selector candidate."
  :group 'auto-complete)

(ac-define-source my-dictionary
  '((candidates . ac-buffer-dictionary)
    (candidate-face . ac-dictionary-candidate-face)
    (selection-face . ac-my-selection-face)
    (symbol . "D")))

;;(setq ac-disable-faces (remove 'font-lock-string-face ac-disable-faces))

(setq-default ac-sources
              '(
                ac-source-filename
                ac-source-yasnippet
                ac-source-dictionary
                ))

;; flyspell mode breaks auto-complete mode without this.
(ac-flyspell-workaround)
