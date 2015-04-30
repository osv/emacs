(add-hook 'c++-mode-hook (lambda () (hs-minor-mode 1)))
;;Длина таба в С++
(add-hook 'c-mode-common-hook
          (lambda ()
            (c-set-style "stroustrup")
	    (setq show-trailing-whitespace t)
	    (setq indent-tabs-mode nil)
            (setq c-basic-offset 4)
            (setq tab-width 4))) 
