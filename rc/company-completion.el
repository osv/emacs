(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(define-key ac-completing-map (kbd "C-g") 'company-files)
