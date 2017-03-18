include vars.mk

help:
	@echo "                Bootstrap Emacs environment"
	@echo "================================================================"
	@echo "Usage:"
	@echo
	@echo "     make nvm"
	@echo "     make all"
	@echo "or"
	@echo	
	@echo "     make setup-profile apt apt-desktop node node-lint node-extra node-tern cpan editorconfig"
	@echo
	@echo "and additionally you can:"
	@echo
	@echo "    make apt-desktop apt-xmonad"
	@echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -"
	@echo "  setup-profile - bash-git-prompt, bash profile, .profile-extra, .Xdefault-Extra"
	@echo "  hipster-tools - exa"
	@echo "  fish - fish shell"
	@echo "  apt - build-essential, pwgen, screen, iptraf, source-highlight"
	@echo "  node - nvm install and use node.js $(NODE_VERSION)"
	@echo "  node-lint - varios lint tools that required by flycheck-mode.el"
	@echo "  node-extra - tern.js gulp, bower, mongohacker, etc"
	@echo "  node-tern - some tern.js plugins"
	@echo "  cpan - csswatcher ack perlcompletion perltidy"
	@echo "  editorconfig - download and install libeditorconfig from source"
	@echo
	@echo 'For update yout profile type "make setup-profile"'
	@echo
	@echo 'To start emacs from DWM better use ~/emacs/exec-emacs that allow you run tern.js, etc in emacs'

info:
	@echo "Cheatsheat:"
	@echo "iotop -aoP    Show accumulated stat"
	@echo " docker --net=host problem. See https://github.com/docker/docker/issues/13914 "
nvm: ~/.nvm/nvm.sh
	@$(PRINT_OK)
	@echo
	@echo "Now run bash again to apply env of nvm"
	@echo "Also you may need run \"make setup-profile\" to setup your .profile"
	@echo "that help use nvm's node (be cause your WM not source .bashrc)."

# nvm install if not exist dir
~/.nvm/nvm.sh:
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash

all: setup-profile hipster-tools apt node node-extra node-lint cpan node-tern editorconfig
	@$(PRINT_OK)

hipster-tools: exa
	@$(PRINT_OK)

# main targers

spacemacs:
ifneq ($(wildcard ~/.emacs.d/.),)
	    @echo "Make copy of your ~/.emacs.d and ~/.emacs first"
			@read -p "Press enter to retry " r
endif
ifneq ($(wildcard ~/.emacs.d/.),)
			@echo "Dir ~/.emacs.d still exist!"
	    @echo "Make copy of your ~/.emacs.d and ~/.emacs first"
			@echo "Aborting"
			@false
endif
ifneq ($(wildcard ~/.emacs), "")
			@echo "File ~/.emacs still exist!"
	    @echo "Make copy of your ~/.emacs.d and ~/.emacs first"
			@echo "Aborting"
			@false
endif
	ln -s ~/emacs/.spacemacs ~/.spacemacs
# git clone --depth 1 https://github.com/syl20bnr/spacemacs ~/.emacs.d
	@$(PRINT_OK)
apt: apt-update apt-make apt-utils
	@$(PRINT_OK)

apt-make:
	sudo apt-get install -y build-essential \
				curl \
				autoconf \
				cmake
# dependencies for editorconf
	sudo apt-get install -y libpcre3 libpcre3-dev
	@$(PRINT_OK)

apt-utils: apt-update
	sudo apt-get install -y iptraf \
				iotop \
				dstat \
				screen \
				pwgen \
				pngquant \
				silversearcher-ag \
				source-highlight
	@$(PRINT_OK)

apt-update:
	sudo apt-get update
	@$(PRINT_OK)

apt-desktop: apt-update
	sudo apt-get install -y scrot \
				perl-doc \
				xfonts-terminus \
				ttf-dejavu \
				conky-cli \
				x11-xserver-utils \
				rxvt-unicode \
				gitk \
				mc \
				kbdd \
				eog \
				ristretto \
				xscreensaver
	@$(PRINT_OK)

apt-xmonad:
	sudo apt-get install -y xmonad \
				dzen2 \
				conky
	@$(PRINT_OK)

editorconfig:
	@echo "*********************************************"
	@echo " Installing libeditorconfig from"
	@echo "    https://github.com/editorconfig/editorconfig-core-c"
	@echo "*********************************************"
	@rm -rf /tmp/editorconfig-build
	git clone https://github.com/editorconfig/editorconfig-core-c /tmp/editorconfig-build
# I test 0.12.1-development and it ok
	(cd /tmp/editorconfig-build && cmake . && make -j ${MAKE_JOBS} && sudo make install)
	@$(PRINT_OK)

node: install-node
	@$(PRINT_OK)

install-node:
	$(NVM) install $(NODE_VERSION)
	$(NVM) use $(NODE_VERSION)
	@$(PRINT_OK)

exa:
	wget -O /tmp/exa.zip https://github.com/ogham/exa/releases/download/v${EXA_LS_VERSION}/exa-linux-x86_64.zip
	(cd /tmp && unzip /tmp/exa.zip && sudo cp -v /tmp/exa-linux-x86_64 /usr/local/bin/exa)
	@$(PRINT_OK)

fish: fish-install fish-fisherman fish-set-config
	@$(PRINT_OK)

fish-set-config:
	ln -s ~/emacs/config.fish ~/.config/fish
	@$(PRINT_OK)
fish-install:
	-git clone --depth 1 --branch ${FISH_VERSION} https://github.com/fish-shell/fish-shell /tmp/fish-shell
	(cd /tmp/fish-shell && autoreconf --no-recursive)
	(cd /tmp/fish-shell && ./configure)
	(cd /tmp/fish-shell && make -j ${MAKE_JOBS})
	(cd /tmp/fish-shell && sudo make install)
	@$(PRINT_OK)

fish-fisherman:
	curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
	-fish -c 'fisher edc/bass brgmnn/fish-docker-compose last_job_id humanize_duration'
	@$(PRINT_OK)

setup-profile: bash-git-prompt bash-extra xdefault-extra
	echo "$$PROFILE_EXTRA" > ~/.profile-extra
ifeq ($(CHECK_PROFILE_EXTRA),)
	echo "$$PROFILE_INLUDE" >> ~/.profile
endif
	@$(PRINT_OK)

node-tern:
	$(NPM) install -g \
			tern-jasmine \
			tern-jasminematchers \
			tern-browser-extension \
			tern-jquery-extension \
			tern-meteor \
			tern-jsx
	@$(PRINT_OK)

node-lint:
	$(NPM) install -g jshint \
			jsonlint \
			csslint \
			js-beautify \
			js-yaml \
			jscs \
			jscs-trailing-comma \
			eslint \
			eslint-plugin-angular \
			less
	@$(PRINT_OK)

# other fix-gaze
node-extra:
	$(NPM) install -g bower \
			grunt-cli \
			gulp \
			http-server \
			mongo-hacker \
			chokidar-cli \
			flow-bin \
			tern \
			elm \
			elm-oracle

	@$(PRINT_OK)

cpan: cpan-csswatcher cpan-ack cpan-perlcompletion cpan-dev
	@$(PRINT_OK)

# etc
CPAN_INSTALL=sudo cpan -i
cpan-csswatcher:
	${CPAN_INSTALL} CSS::Watcher
	@$(PRINT_OK)

cpan-pde:
	${CPAN_INSTALL} Devel::CoverX::Covered
	${CPAN_INSTALL} Devel::PerlySense Emacs::PDE
	@$(PRINT_OK)

# need for helm-projectile-ack
cpan-ack:
	${CPAN_INSTALL} App::Ack
	@$(PRINT_OK)

cpan-perlcompletion:
# need for perl-completion
	${CPAN_INSTALL} Class::Inspector
	@$(PRINT_OK)

cpan-dev:
	${CPAN_INSTALL} Perl::Critic Perl::Tidy
	@$(PRINT_OK)

bash-git-prompt:
	@mkdir -p ~/tools/other
# see .bash-extra, where is check for existing dir bash-git-prompt
	@-git clone --depth 1 https://github.com/magicmonty/bash-git-prompt.git ~/work/tools/bash-git-prompt
	@$(PRINT_OK)

bash-extra:
	@cp -v .bash-extra ~/
ifeq ($(CHECK_BASH_EXTRA),)
	echo "$$BASH_INLUDE" >> ~/.bashrc
endif
	@$(PRINT_OK)

haskell:
	curl -sSL https://get.haskellstack.org/ | sh

xdefault-extra:
	@cp -v .Xdefaults-extra ~/
ifeq ($(CHECK_XDEFAULTS_EXTRA),)
	echo "$$XDEFAULTS_INLUDE" >> ~/.Xdefaults
endif
	@$(PRINT_OK)

clean:
	@echo "You should remove next resource manually:"
	@echo " ~/work/tools/bash-git-prompt"
	@echo " $(NPM_GLOBAL_PATH)"
	@echo " ~/.profile-extra"
	@echo " ~/.bash-extra"
