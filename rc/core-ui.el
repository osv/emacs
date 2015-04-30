;; disable startup screen
(setq inhibit-startup-screen t)

;; no toolbar
(tool-bar-mode 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; hour format
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)
(setq calendar-date-display-form (quote ((format "%04s-%02d-%02d" year (string-to-int month) (string-to-int day)))))
(setq calendar-time-display-form (quote (24-hours ":" minutes (if time-zone " (") time-zone (if time-zone ")"))))
(setq calendar-week-start-day 1)
(setq european-calendar-style t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;my favourite scrolling
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq scroll-conservatively 50)
(setq scroll-preserve-screen-position 't)
(setq scroll-margin 5)

(when (display-graphic-p)
  (set-scroll-bar-mode 'nil))

(setq compilation-scroll-output t)
;;
(transient-mark-mode 1)
(setq mark-even-if-inactive t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; display a little marker in the left fringe (for empty lines)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq default-indicate-empty-lines t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mark end of file by '~~~eof~' symbols
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-mark-eob ()
  (let ((existing-overlays (overlays-in (point-max) (point-max)))
	(eob-mark (make-overlay (point-max) (point-max) nil t t))
	(eob-text "~~~eof~"))
    ;; Delete any previous EOB markers.  Necessary so that they don't
    ;; accumulate on calls to revert-buffer.
    (dolist (next-overlay existing-overlays)
      (if (overlay-get next-overlay 'eob-overlay)
	  (delete-overlay next-overlay)))
    ;; Add a new EOB marker.
    (put-text-property 0 (length eob-text)
		       'face '(foreground-color . "slate gray") eob-text)
    (overlay-put eob-mark 'eob-overlay t)
    (overlay-put eob-mark 'after-string eob-text)))
(add-hook 'find-file-hooks 'my-mark-eob)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Show current function in modeline
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(which-function-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Change all yes/no questions to y/n type
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(fset 'yes-or-no-p 'y-or-n-p) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; title name
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq-default frame-title-format (list "Emacs: %f"))
(setq-default icon-title-format "Emacs - %b") 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mode line settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; make the fringe (gutter) smaller
;; the argument is a width in pixels (the default is 8)
(if (fboundp 'fringe-mode)
    (fringe-mode 6))
