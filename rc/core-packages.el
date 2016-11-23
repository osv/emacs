(require 'cl)
(require 'package) ;; You might already have this line

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("e6h" . "http://www.e6h.org/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))

(package-initialize) ;; You might already have this line

(defvar my--packages
  '(
    ;; themes
    aurora-theme
    alect-themes
    autumn-light-theme
    atom-dark-theme
    grandshell-theme
    gotham-theme

    org

    ac-etags
    ac-html
    ac-html-angular
    ac-html-bootstrap
    ac-html-csswatcher
    apache-mode
    bash-completion
    company-web
    web-completion-data
    emmet-mode
    ace-jump-mode
    ace-jump-helm-line
    ace-window ;; required by
    anything
    angular-snippets
;;    ace-isearch
    anzu
    apel
    async
    auto-complete
    bbdb-
    bbdb
    btc-ticker
    cg
    coffee-mode
    company
    company-dict
    company-flow                        ; js autocomple
    company-tern
    company-shell
    company-statistics
    company-restclient
    company-try-hard
    css-eldoc
    crontab-mode
    dash
    digit-groups
    diminish
    dired-hacks-utils
    dired-rainbow
    dired-single
    direx
    discover
    discover-js2-refactor
    dockerfile-mode
    editorconfig
    egg
    expand-region
    erlang
    elm-mode
    feature-mode
    fireplace
    flim
    flx
    flx-ido
    flycheck
    flymake-easy
    flycheck-elm
    flycheck-flow
    glsl-mode
    go-mode
    google-translate
    git-gutter
    haskell-mode
    helm
    helm-company
    helm-css-scss
    helm-flycheck
    helm-google
    helm-projectile
    helm-swoop
    highlight-parentheses
    highlight-indent-guides
    idle-highlight-mode
    jabber
    js2-mode
    js-doc
    js2-refactor
    js2-highlight-vars
    rjsx-mode
    json-mode
    json-reformat
    lua-mode
    minimap
    multiple-cursors
    neotree
    nyan-mode
    nginx-mode
    volatile-highlights
    org-pomodoro
    php-mode
    plsense
    plsense-direx
    popup
    projectile
    rainbow-mode
    restclient
    region-state
;;    register-channel
    simple-httpd
    slime
    string-inflection
    sudo-edit
    smartparens
    sos
    tern
    tern-auto-complete
    undo-tree
    w3m
;;    wanderlust
    web-beautify
    web-mode
    wttrin                              ; wheather
    window-numbering
    yaml-mode
    yaml-tomato
    yasnippet
    yaxception
    jade-mode
    less-css-mode
    sass-mode
    scss-mode
    slim-mode
    stylus-mode
    markdown-mode
    haml-mode
    impatient-mode
    htmlize
    )
  "A list of packages to ensure are installed at launch.")

(defvar my--ignore-list
  '(
    xterm-color
    helm-core
    json-snatcher
    let-alist
    log4e
    makey
    merlin
    pkg-info
    sws-mode
    dash-functional
    avy
    alert
    f
    s
    epl
    gntp
    seq
    bpr
    request
    hexrgb
    )
  "Don't show next packages in not bundled. They installed as dependence")

(defun my--packages-installed-p ()
  "Check if all packages in `my--packages' are installed."
  (every #'package-installed-p my--packages))

(defun my--require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package my--packages)
    (add-to-list 'my--packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun my--require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'my--require-package packages))

(define-obsolete-function-alias 'my--ensure-module-deps 'my--require-packages)

(defun my--install-packages ()
  "Install all packages listed in `my--packages'."
  (unless (my--packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (my--require-packages my--packages)))

;; run package installation
(my--install-packages)

(defun my-list-foreign-packages ()
  "Browse third-party packages not bundled.
Behaves similarly to `package-list-packages', but shows only the packages that
are installed and are not in `my--packages'. Useful for
removing unwanted packages."
  (interactive)
  (package-show-package-list
   (set-difference package-activated-list (append my--packages my--ignore-list))))
