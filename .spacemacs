;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     python
     lsp
     sml
     go
     csv
     php
     elm
     purescript
     yaml
     restclient
     typescript
     shell-scripts
     sql
     docker
     ruby
     html
     haskell
     javascript
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     (auto-completion :variables
                      auto-completion-enable-help-tooltip nil
                      auto-completion-tab-key-behavior nil
                      auto-completion-return-key-behavior nil
                      auto-completion-enable-snippets-in-popup t)
     ;; better-defaults
     emacs-lisp
     git
     markdown
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     (spell-checking :variables spell-checking-enable-by-default nil)
     (syntax-checking :variables syntax-checking-use-original-bitmaps nil)
     version-control
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages
   '(
     ;; prog-fill, magit-todos require emacs 25.1
     feature-mode
     color-theme-sanityinc-tomorrow
     diredfl
     wgrep
     nginx-mode
     editorconfig
     rainbow-mode
     string-inflection
     dired-rainbow
     pomidor
     project-shells
     project-explorer
     egg
     prettier-js
     )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'random
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 14
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 1.0
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  (diredfl-global-mode +1)

  ;; Navigate windows with M-<arrows>
  (windmove-default-keybindings 'meta)
  (setq windmove-wrap-around t)

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

  (spacemacs|diminish egg-mode)

  ;; Projectile
  (setq projectile-globally-ignored-directories
        '(".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox"
          ".svn" "build" "vendor" "cms/ext" "cms/Sencha"
          "coverage" "closure-library" "public" "node_modules" "bower_components" ".idea" "_project"
          ".meteor/local" "build" ".tmp"))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; etc
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (setq scroll-margin 3)
  (which-function-mode t)
  (editorconfig-mode 1)

  ;; https://github.com/syl20bnr/spacemacs/issues/3828
  (add-hook 'change-major-mode-after-body-hook
            (lambda ()
              (when (> (buffer-size) 80000)
                (turn-off-show-smartparens-mode))))

  (global-set-key (kbd "\C-z") 'undo)

  (global-set-key [C-f4] 'next-error) ;; C-x `
  ;; (define-key js2-mode-map [f4] 'js2-next-error)

  (global-set-key [S-f4] 'previous-error)

  ;; Add F12 to toggle line wrap
  (global-set-key [f12] 'toggle-truncate-lines)
  (global-set-key (kbd "C-x C-\\")  'goto-last-change)

  (global-set-key (kbd "M-S-<right>") 'string-inflection-all-cycle)
  (global-set-key (kbd "M-S-<up>") 'string-inflection-camelcase)
  (global-set-key (kbd "M-S-<down>") 'string-inflection-lower-camelcase)
  (global-set-key (kbd "M-S-<left>") 'string-inflection-lisp)

  (global-set-key (kbd "M-%") 'anzu-query-replace)
  (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

  (global-set-key (kbd "C-c e") 'egg-status)

  (global-set-key (kbd "C-=") 'er/expand-region)

  (global-set-key (kbd "C-c C-<left>")  'hs-hide-block)
  (global-set-key (kbd "C-c C-<right>") 'hs-show-block)
  (global-set-key (kbd "C-c C-<up>") 'hs-hide-level)
  (global-set-key (kbd "C-c C-<down>") 'hs-toggle-hiding)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; dired
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (require 'dired-rainbow)
  ;; (dired-rainbow-define webhtml "#aaf" ("htm" "html" "xhtml"))
  ;; (dired-rainbow-define web "#77f" ("css" "less"))
  ;; (dired-rainbow-define media "#ce5c00" ("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg"))
  ;; (dired-rainbow-define junk "#333" ("hi" "o" "hs1"))
  ;; (dired-rainbow-define source  "#cf5" ("hs" "pl" "js" "el"))

  ;;                                       ; boring regexp due to lack of imagination
  ;; (dired-rainbow-define log (:inherit default
  ;;                                     :italic t) ".*\\.log")

  ;;                                       ; highlight executable files, but not directories
  ;; (dired-rainbow-define-chmod executable-unix "green" "-.*x.*")
  (global-set-key [C-f5] 'dired-jump)
  (global-set-key (kbd "C-c p C-s") 'helm-projectile-ag)

  (global-set-key [f5] 'project-explorer-open)

  (global-set-key [f9] 'pomidor)
  (global-set-key [f11] 'flycheck-mode)

  (setq pomidor-sound-tick nil
        pomidor-sound-tack nil
        ;; pomidor-sound-overworknil
        )

  ;; See for more example of configuration https://github.com/TheBB/spacemacs-layers/blob/master/init.el
  (use-package git-gutter+
    :config
    (progn
      ;; I don't like right fringe
      (git-gutter+-toggle-fringe)
      (setq git-gutter+-modified-sign "=")))

  (use-package web-mode
    :config
    (progn
      (define-key web-mode-map (kbd "TAB") 'indent-for-tab-command)))

  (defun sql-beautify-region (beg end)
    "Beautify SQL in region between beg and END.
Dependency:
npm i -g sql-formatter-cli"
    (interactive "r")
    (save-excursion
      (shell-command-on-region beg end "sql-formatter" nil t)))
  (defun sql-beautify-buffer ()
    "Beautify SQL in buffer."
    (interactive)
    (sql-beautify-region (point-min) (point-max)))
  (add-hook 'sql-mode-hook '(lambda ()
                              ;; beautify region or buffer
                              (local-set-key (kbd "C-c t") 'sql-beautify-region)))

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
  (setq-default
   ;; web-mode-enable-auto-pairing t
   ;; web-mode-enable-auto-opening t
   web-mode-enable-auto-quoting nil
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
  (remove-hook 'web-mode-hook 'spacemacs/toggle-smartparens-off)

  (use-package editorconfig
    :config
    (progn
      (spacemacs|diminish editorconfig-mode)
      (editorconfig-mode 1)))

  (smartparens-global-mode)
  (global-company-mode)
  (add-hook 'after-init-hook 'company-statistics-mode)
  (setq company-idle-delay .3
        company-dabbrev-downcase 'nil
        company-tooltip-align-annotations 't)
  (define-key company-mode-map (kbd "C-'") 'helm-company)
  (define-key company-active-map (kbd "C-'") 'helm-company)
  (global-set-key (kbd "C-c /") 'company-files)
  (global-set-key (kbd "C-c ?") 'company-ispell)
  (global-set-key (kbd "C-c SPC") 'company-tern)
  (global-set-key (kbd "M-?") 'company-complete-common)

  (setq yas-snippet-dirs (append '("~/emacs/dicts/snippets") yas-snippet-dirs ))

  (setq ido-use-filename-at-point 'guess)

  (global-set-key (kbd "M-p") 'flyspell-check-previous-highlighted-word)

  (defun my/use-tslint-from-node-modules ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
           (tslint (and root
                        (expand-file-name "node_modules/.bin/tslint"
                                          root))))
      (when (and tslint (file-executable-p tslint))
        (setq-local flycheck-typescript-tslint-executable tslint))))

  (add-hook 'flycheck-mode-hook #'my/use-tslint-from-node-modules)

  ;; http://chopmo.blogspot.com/2008/09/quickly-jumping-to-symbols.html
  (defun ido-goto-symbol ()
    "Will update the imenu index and then use ido to select a
   symbol to navigate to"
    (interactive)
    (imenu--make-index-alist)
    (let ((name-and-pos '())
          (symbol-names '()))
      (flet ((addsymbols (symbol-list)
                         (when (listp symbol-list)
                           (dolist (symbol symbol-list)
                             (let ((name nil) (position nil))
                               (cond
                                ((and (listp symbol) (imenu--subalist-p symbol))
                                 (addsymbols symbol))
                                ((listp symbol)
                                 (setq name (car symbol))
                                 (setq position (cdr symbol)))
                                ((stringp symbol)
                                 (setq name symbol)
                                 (setq position (get-text-property 1 'org-imenu-marker symbol))))
                               (unless (or (null position) (null name))
                                 (add-to-list 'symbol-names name)
                                 (add-to-list 'name-and-pos (cons name position))))))))
        (addsymbols imenu--index-alist))
      (let* ((selected-symbol (ido-completing-read "Symbol? " symbol-names))
             (position (cdr (assoc selected-symbol name-and-pos))))
        (goto-char position))))

  (global-set-key (kbd "C-t") 'ido-goto-symbol) ; instead transpose-chars use complete symbol
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "44c566df0e1dfddc60621711155b1be4665dd3520b290cb354f8270ca57f8788" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(js2-mode-show-parse-errors nil)
 '(js2-strict-missing-semi-warning nil)
 '(js2-strict-trailing-comma-warning nil)
 '(evil-want-Y-yank-to-eol nil)
 '(helm-autoresize-max-height 100)
 '(magit-diff-refine-hunk (quote all))
 '(neo-show-updir-line t t)
 '(neo-vc-integration (quote (face char)) t)
 '(paradox-github-token t)
 '(web-mode-script-padding 2)
 '(web-mode-style-padding 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
)
