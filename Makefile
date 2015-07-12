NODE_VERSION          = v0.12.4
CHECK_PROFILE_EXTRA   = $(shell grep 'HOME/.profile-extra' ~/.profile)
NPM_GLOBAL_PATH       = $(HOME)/npm
NPM		      = $(NPM_GLOBAL_PATH)/bin/npm
TERN_PLUG_DIR         = $(NPM_GLOBAL_PATH)/lib/node_modules/tern/plugin
# 86 or 64
ARCH                  = 64
ifeq ($(shell getconf LONG_BIT),32)
ARCH=86
endif

NODE_URL              = http://nodejs.org/dist/$(NODE_VERSION)/node-$(NODE_VERSION)-linux-x$(ARCH).tar.gz

# next heredoc will be included to .profile
define PROFILE_INLUDE

# Autogenerate by ~/emacs/Makefile at "$(shell date)"
# additional setup, like PATH for node, less colorize
if [ -n "$$HOME/.profile-extra" ] ; then
    . "$$HOME/.profile-extra"
fi
# end generete part
endef

export PROFILE_INLUDE

# heredoc content of ~/.profile-extra
define PROFILE_EXTRA
#!/bin/bash
#Setup env
  if [ -d "$(NPM_GLOBAL_PATH)/bin" ] ; then
      PATH="$(NPM_GLOBAL_PATH)/bin:$$PATH"
      NODE_PATH="$(NPM_GLOBAL_PATH)/lib/node_modules:$$NODE_PATH"
  fi

  export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
  export LESS=' -R '
endef

export PROFILE_EXTRA

help:
	@echo "Bootstrap Emacs environment"
	@echo "Usage:"
	@echo "     make all"
	@echo "or"
	@echo "     make apt node cpan tern"
	@echo
	@echo "Note: NPM prefix will be $(NPM_GLOBAL_PATH)"

all: setup-profile apt node node-extra cpan tern editorconfig

# main targers

apt:
	sudo apt-get install build-essential cmake perl-doc source-highlight
# dependencies for editorconf
	sudo apt-get install libpcre3 libpcre3-dev

editorconfig:
	@echo "*********************************************"
	@echo " Installing libeditorconfig from"
	@echo "    https://github.com/editorconfig/editorconfig-core-c"
	@echo "*********************************************"
	@rm -rf /tmp/editorconfig-build
	git clone https://github.com/editorconfig/editorconfig-core-c /tmp/editorconfig-build
	(cd /tmp/editorconfig-build && cmake . && make && sudo make install)

node: node-install node-setup
	$(NPM) install -g jshint jsonlint tern csslint js-beautify js-yaml
# gaze, for fix watchers of gulp
	$(NPM) install -g fix-gaze

node-install:
	mkdir -p $(NPM_GLOBAL_PATH)
	@echo "********************************************"
	@echo " Installing node into $(NPM_GLOBAL_PATH)"
	@echo "********************************************"
	curl $(NODE_URL) -s -o - | tar xzf - -C $(NPM_GLOBAL_PATH)
	cp -r $(NPM_GLOBAL_PATH)/node-$(NODE_VERSION)-linux-x$(ARCH)/* $(NPM_GLOBAL_PATH)
	@rm -rf $(NPM_GLOBAL_PATH)/node-$(NODE_VERSION)-linux-x$(ARCH)

setup-profile:
	echo "$$PROFILE_EXTRA" > ~/.profile-extra
ifeq ($(CHECK_PROFILE_EXTRA),)
	echo "$$PROFILE_INLUDE" >> ~/.profile
endif

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
tern:
	curl https://raw.githubusercontent.com/Slava/tern-meteor/master/meteor.js > /tmp/meteor.js
	cp /tmp/meteor.js ${TERN_PLUG_DIR}

node-extra:
	$(NPM) install -g bower grunt-cli gulp

cpan: cpan-pde cpan-csswatcher cpan-ack cpan-perlcompletion cpan-dev

# etc
CPAN_INSTALL=sudo cpan -i
cpan-csswatcher:
	${CPAN_INSTALL} CSS::Watcher

cpan-pde:
	${CPAN_INSTALL} Devel::CoverX::Covered
	${CPAN_INSTALL} Devel::PerlySense Emacs::PDE

# need for helm-projectile-ack
cpan-ack:
	${CPAN_INSTALL} App::Ack

cpan-perlcompletion:
# need for perl-completion
	${CPAN_INSTALL} Class::Inspector

cpan-dev:
	${CPAN_INSTALL} Perl::Critic Perl::Tidy
