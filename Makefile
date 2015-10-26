 include vars.mk

help:
	@echo "Bootstrap Emacs environment"
	@echo "Usage:"
	@echo "     make all"
	@echo "or"
	@echo "     make setup-profile apt apt-desktop node node-extra node-lint cpan tern editorconfig"
	@echo
	@echo "and additionally you can:"
	@echo "    make apt-desktop"
	@echo "Note: NPM prefix will be $(NPM_GLOBAL_PATH)"

all: setup-profile apt node node-extra node-lint cpan tern editorconfig
	@$(PRINT_OK)

# main targers

apt: apt-update apt-utils
	sudo apt-get install -y build-essential \
				curl \
				cmake
# dependencies for editorconf
	sudo apt-get install -y libpcre3 libpcre3-dev pwgen
	@$(PRINT_OK)

apt-desktop: apt-update
	sudo apt-get install -y scrot \
				perl-doc \
				xfonts-terminus \
				conky-cli \
				x11-xserver-utils \
				xscreensaver
	@$(PRINT_OK)

apt-utils: apt-update
	sudo apt-get install -y iptraf \
				screen \
				source-highlight
	@$(PRINT_OK)

apt-update:
	sudo apt-get update
	@$(PRINT_OK)

editorconfig:
	@echo "*********************************************"
	@echo " Installing libeditorconfig from"
	@echo "    https://github.com/editorconfig/editorconfig-core-c"
	@echo "*********************************************"
	@rm -rf /tmp/editorconfig-build
	git clone https://github.com/editorconfig/editorconfig-core-c /tmp/editorconfig-build
	(cd /tmp/editorconfig-build && cmake . && make && sudo make install)
	@$(PRINT_OK)

node: node-install node-setup
	@$(PRINT_OK)

node-install:
	mkdir -p $(NPM_GLOBAL_PATH)
	@echo "********************************************"
	@echo " Installing node into $(NPM_GLOBAL_PATH)"
	@echo "********************************************"
	curl $(NODE_URL) -s -o - | tar xzf - -C $(NPM_GLOBAL_PATH)
	cp -r $(NPM_GLOBAL_PATH)/node-$(NODE_VERSION)-linux-x$(ARCH)/* $(NPM_GLOBAL_PATH)
	@rm -rf $(NPM_GLOBAL_PATH)/node-$(NODE_VERSION)-linux-x$(ARCH)
	@$(PRINT_OK)

setup-profile: bash-git-prompt bash-extra
	echo "$$PROFILE_EXTRA" > ~/.profile-extra
ifeq ($(CHECK_PROFILE_EXTRA),)
	echo "$$PROFILE_INLUDE" >> ~/.profile
endif
	@$(PRINT_OK)

node-setup:
ifeq ($(CHECK_NPM_BIN_PROFILE),)
	@echo "********************************************"
	@echo "I setup NPM prefix to: $(NPM_GLOBAL_PATH)"
	@echo "********************************************"
	mkdir -p $(NPM_GLOBAL_PATH)
	$(NPM) config set prefix $(NPM_GLOBAL_PATH)
	echo "$$PROFILE_INLUDE" >> ~/.profile
	@echo "You need relogin to apply ~/.profile changes globally"
endif
	@echo "npm setup done"
	@$(PRINT_OK)

tern:
	curl https://raw.githubusercontent.com/Slava/tern-meteor/master/meteor.js > /tmp/meteor.js
	cp /tmp/meteor.js ${TERN_PLUG_DIR}
	@$(PRINT_OK)

node-lint:
	$(NPM) install -g jshint \
			jsonlint \
			csslint \
			js-beautify \
			js-yaml \
			less
	@$(PRINT_OK)

node-extra:
	$(NPM) install -g bower \
			grunt-cli \
			gulp \
			fix-gaze \
			tern

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
	@-git clone --depth 1 https://github.com/magicmonty/bash-git-prompt.git ~/work/tools/bash-git-prompt
	@$(PRINT_OK)

bash-extra:
	@cp -v .bash-extra ~/
ifeq ($(CHECK_BASH_EXTRA),)
	echo "$$BASH_INLUDE" >> ~/.bashrc
endif
	@$(PRINT_OK)

clean:
	@echo "You should remove next resource manually:"
	@echo " ~/work/tools/bash-git-prompt"
	@echo " $(NPM_GLOBAL_PATH)"
	@echo " ~/.profile-extra"
	@echo " ~/.bash-extra"
