;; graphviz-dot-mode 
(setq auto-mode-alist (cons '("\\.gv$" . graphviz-dot-mode) auto-mode-alist))
(autoload 'graphviz-dot-mode "graphviz-dot-mode" "Major mode for editing material files" t)


(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

(autoload 'glsl-mode "glsl-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.vert\\'" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.glsl\\'" . glsl-mode)) 
(add-to-list 'auto-mode-alist '("\\.frag\\'" . glsl-mode)) 

(autoload 'cg-mode "cg-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.cg\\'" . cg-mode))
(add-to-list 'auto-mode-alist '("\\.hlsl\\'" . cg-mode))

;; celestia
(autoload 'celssc-mode "celssc-mode" "Major mode for editing celesita's solar system catalog files" t)
(setq auto-mode-alist (cons '("\\.ssc" . celssc-mode)
			    auto-mode-alist))
(autoload 'celssc-mode "celssc-mode" "Major mode for editing celesita's star catalog files" t)
(setq auto-mode-alist (cons '("\\.stc" . celssc-mode)
			    auto-mode-alist))
(autoload 'celssc-mode "celssc-mode" "Major mode for editing celesita's deep sky catalog files" t)
(setq auto-mode-alist (cons '("\\.dsc" . celssc-mode)
			    auto-mode-alist))

;; ;; Babylon 5
;; (autoload 'b5str-mode "b5str-mode" "Major mode for editing str files" t)
;; (setq auto-mode-alist (cons '("\\.str" . b5str-mode)
;; 			    auto-mode-alist))

;; (autoload 'b5map-mode "b5map-mode" "Major mode for editing .map files" t)
;; (setq auto-mode-alist (cons '("\\.map" . b5map-mode)
;; 			    auto-mode-alist)) 

;; (autoload 'ogrescr-mode "ogrescr-mode" "Major mode for editing material files" t)
;; (setq auto-mode-alist (cons '("\\.material" . ogrescr-mode)
;; 			    auto-mode-alist))
;; (autoload 'ogrescr-mode "ogrescr-mode" "Major mode for editing compositor files" t)
;; (setq auto-mode-alist (cons '("\\.compositor" . ogrescr-mode)
;; 			    auto-mode-alist))
;; (autoload 'ogrescr-mode "ogrescr-mode" "Major mode for editing program files" t)
;; (setq auto-mode-alist (cons '("\\.program" . ogrescr-mode)
;; 			    auto-mode-alist))
;; (autoload 'ogreovl-mode "ogreovl-mode" "Major mode for editing overlay files" t)
;; (setq auto-mode-alist (cons '("\\.overlay" . ogreovl-mode)
;; 			    auto-mode-alist))
;; (autoload 'ogreprt-mode "ogreprt-mode" "Major mode for editing particle files" t)
;; (setq auto-mode-alist (cons '("\\.particle" . ogreprt-mode)
;; 			    auto-mode-alist))

;; (autoload 'ogrefnt-mode "ogrefnt-mode" "Major mode for editing fontdef files" t)
;; (setq auto-mode-alist (cons '("\\.fontdef" . ogrefnt-mode)
;; 			    auto-mode-alist))
