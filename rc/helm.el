;;`helm-wikipedia-suggest'

;; C-' when helming, press for ace


(setq default-frame-alist '((vertical-scroll-bars . nil)
                            (tool-bar-lines . 0)
                            (menu-bar-lines . 0)
                            (fullscreen . nil)))

;;(add-to-list 'load-path (expand-file-name "~/emacs/helm"))
(require 'helm)
(require 'helm-config)
(require 'diminish)
(helm-mode 1)
(diminish 'helm-mode)

;;(define-key global-map [remap find-file] 'helm-find-files)
(define-key global-map [remap occur] 'helm-occur)
(define-key global-map (kbd "C-c h i") 'imenu)
(define-key global-map [remap list-buffers] 'helm-buffers-list)
;;(define-key global-map [remap dabbrev-expand] 'helm-dabbrev)
(unless (boundp 'completion-in-region-function)
  (define-key lisp-interaction-mode-map [remap completion-at-point] 'helm-lisp-completion-at-point)
  (define-key emacs-lisp-mode-map       [remap completion-at-point] 'helm-lisp-completion-at-point))

;; flycheck
(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

;; projectile
;; `C-c p' - prefix
(require 'helm-projectile)
(helm-projectile-on)
(global-set-key (kbd "C-c p C-s") 'helm-projectile-ack)

(require 'helm-swoop)
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; From helm-swoop to helm-multi-swoop-all
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)

(require 'ace-jump-helm-line)
(define-key helm-map (kbd "C-'") 'ace-jump-helm-line)
