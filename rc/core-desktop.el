;; https://mail.haskell.org/pipermail/xmonad/2008-January/004471.html
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

(add-to-list 'auto-mode-alist '("\\.cron\\(tab\\)?\\'" . crontab-mode))
(add-to-list 'auto-mode-alist '("cron\\(tab\\)?\\."    . crontab-mode))

;; assoc nginx conf
(add-to-list 'auto-mode-alist '("nginx.*conf$" . nginx-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; diminish keeps the modeline tidy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'diminish)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rainbow colorize hmtl codes
(require 'region-state)
(region-state-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rainbow colorize hmtl codes
(require 'rainbow-mode)
(diminish 'rainbow-mode)

(setq browse-url-browser-function 'browse-url-firefox
      browse-url-new-window-flag  t
      browse-url-firefox-new-window-is-tab t)

(setq highlight-current-line-on t)
;;(load-file "~/emacs/rc-cedet.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; GNUS
;; this need for file sync on win 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq nnheader-file-name-translation-alist '((?: . ?_)))
;; http://demyan.tumblr.com/post/41271440/gnus-attachment-rfc-2231
(add-hook 'message-mode-hook
	  '(lambda ()
	     (defalias 'mail-header-encode-parameter 'rfc2045-encode-string)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; highlight current word
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'idle-highlight "idle-highlight" "Highlight the word the point is on" t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ido completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; `M-m' mkdir
;; `C-f' toggle FILE
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-default-file-method 'selected-window
      ido-auto-merge-work-directories-length -1)
(ido-mode +1)

;;; smarter fuzzy matching for ido
(flx-ido-mode +1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; savehist keeps track of some history
(require 'saveplace)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; activate it for all buffers
(setq-default save-place t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-c p p
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(projectile-global-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; anzu-mode enhances isearch & query-replace by showing total matches and current match position
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'anzu)
(diminish 'anzu-mode)
(global-anzu-mode)

(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; git-gutter
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'git-gutter)
(diminish 'git-gutter-mode)
(global-git-gutter-mode +1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; egg git
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'egg)
(global-set-key (kbd "C-c e") 'egg-status)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; parent match highlight
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'highlight-parentheses)

(defun count-words--message (str start end)
  (let* ((lines (count-lines start end))
         (words (count-words start end))
         (chars (- end start))
         (yegges (/ (+ (/ words 4000.0) (/ chars 25000.0)) 2)))
    (message "%s has %d line%s, %d word%s, %f Yegge%s and %d character%s."
	     str
	     lines (if (= lines 1) "" "s")
	     words (if (= words 1) "" "s")
             yegges (if (= yegges 1) "" "s")
	     chars (if (= chars 1) "" "s"))))

(global-set-key (kbd "M-p") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
;; (global-set-key (kbd "M-S-p") 'flyspell-check-next-highlighted-word)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Set up recentf so I can get a list of recent files when I start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(recentf-mode 1)
(recentf-open-files nil "*Recent Files*")
(setq recentf-max-saved-items 120) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; timer morning
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-timer-morning ()
  (delete-other-windows)
  (split-window)
  (org-agenda-list)  
  )

(run-at-time "7:30am" 86400 'my-timer-morning)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hideshow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'hideshow)
(global-set-key (kbd "C-c C-<left>")  'hs-hide-block)
(global-set-key (kbd "C-c C-<right>") 'hs-show-block)
(global-set-key (kbd "C-c C-<up>") 'hs-hide-level) 
(global-set-key (kbd "C-c C-<down>") 'hs-toggle-hiding) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; rainbow
(require 'dired-rainbow)
(dired-rainbow-define webhtml "#aaf" ("htm" "html" "xhtml"))
(dired-rainbow-define web "#77f" ("css" "less"))
(dired-rainbow-define media "#ce5c00" ("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg"))

(dired-rainbow-define source  "#cf5" ("pl" "js" "el"))

; boring regexp due to lack of imagination
(dired-rainbow-define log (:inherit default
                           :italic t) ".*\\.log")

; highlight executable files, but not directories
(dired-rainbow-define-chmod executable-unix "green" "-.*x.*")

(require 'dired-single)
;;(require 'dired-history)
(defun my-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when it's
        loaded."
  ;; <add other stuff here>
  (define-key dired-mode-map [return] 'dired-single-buffer)
  (define-key dired-mode-map [mouse-1] 'dired-single-buffer-mouse)
  (define-key dired-mode-map "^"
    (function
     (lambda nil (interactive) (dired-single-buffer ".."))))
  (define-key dired-mode-map "/"
    (function
     (lambda nil (interactive) (dired-single-buffer "..")))))

;; if dired's already loaded, then the keymap will be bound
(if (boundp 'dired-mode-map)
    ;; we're good to go; just add our bindings
    (my-dired-init)
  ;; it's not loaded yet, so add our bindings to the load-hook
  (add-hook 'dired-load-hook 'my-dired-init))

(global-set-key [(f5)] 'dired-single-magic-buffer)
(global-set-key [(control f5)] (function
				(lambda nil (interactive)
				  (dired-single-magic-buffer default-directory))))
(global-set-key [(shift f5)] (function
			      (lambda nil (interactive)
				(message "Current directory is: %s" default-directory))))
(global-set-key [(meta f5)] 'dired-single-toggle-buffer-name)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; nyan-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (display-graphic-p)
  (nyan-mode t)
  (nyan-start-animation)
  (setq nyan-bar-length 12))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; window-numbering
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(window-numbering-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multiple cursor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; compile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'compile)
(setq compilation-always-kill t         ; Just kill old compile processes before
                                        ; starting the new one
      compilation-scroll-output 'first-error ; Automatically scroll to first
                                        ; error
      )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sensible undo
;; `M-_' `C-?' redo 
;; `C-x u' visualize 
;;     t - timestamp;
;;     f, b - select branch;
;;      ., , - scroll
;;     d - diff
;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'yasnippet)
(setq yas-snippet-dirs (append '("~/emacs/dicts/snippets") yas-snippet-dirs ))
(yas-global-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-x r - fancy
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'discover)
(global-discover-mode 1)

;;Open as root---------------------------------
;;Ask if I want to open file as root (and use tramp-sudo to give
;;permission)
;; See http://home.thep.lu.se/~karlf/emacs.html
(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))

;;Awesome copy/paste!----------------------
;;My most used hack! If nothing is marked/highlighted, and you copy or cut
;;(C-w or M-w) then use column 1 to end. No need to "C-a C-k" or "C-a C-w" etc.
;; See  http://home.thep.lu.se/~karlf/emacs.html
(defadvice kill-ring-save (before slick-copy activate compile) "When called
  interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
        (line-beginning-position 2)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Highlight  the latest  changes in  the buffer  (like text  inserted
;; from: yank, undo, etc.)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'volatile-highlights)
(volatile-highlights-mode t)
(diminish 'volatile-highlights-mode)

(autoload 'goto-last-change "goto-last-change"
  "Set point to the position of the last change." t)
(global-set-key (kbd "C-x C-\\")  'goto-last-change)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expand-region
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; colorize emacs compilation buffer
;; http://stackoverflow.com/questions/3072648/cucumbers-ansi-colors-messing-up-emacs-compilation-buffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; bash completion setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'bash-completion-dynamic-complete "bash-completion"
  "BASH completion hook")
(add-hook 'shell-dynamic-complete-functions
          'bash-completion-dynamic-complete)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; etc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; just once ask passwd
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

(global-set-key (kbd "\C-z") 'undo)

(global-set-key [C-f4] 'next-error) ;; C-x `
(global-set-key [S-f4] 'previous-error)

;; Add F12 to toggle line wrap
(global-set-key [f12] 'toggle-truncate-lines)

;; copy-paste
(global-set-key [(shift delete)] 'clipboard-kill-region)
(global-set-key [(shift insert)] 'clipboard-yank)
(global-set-key [(control insert)] 'clipboard-kill-ring-save) 

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)
