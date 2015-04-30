;; jabber.el

(setq jabber-auto-reconnect t)

;; (setq jabber-muc-colorize-local t)
(setq jabber-muc-colorize-foreign t)

(require 'jabber-autoaway)
(require 'jabber-alert)
;; wtf?
(add-hook 'jabber-chat-mode-hook #'(lambda ()
				     (set redisplay-dont-pause t
					   scroll-margin 2
					   scroll-step 1
					   scroll-conservatively 10000
					   scroll-preserve-screen-position 1)

                                     (set fill-column 72)
					;                                     (turn-on-auto-fill)
				     ))
(setq jabber-use-global-history t)
(setq jabber-history-enabled t)
(setq jabber-history-enable-rotation t)

(global-set-key (kbd "C-x C-j l") 'jabber-switch-to-roster-buffer)
;; some notifers

(add-hook 'jabber-chat-mode-hook 'flyspell-mode)
