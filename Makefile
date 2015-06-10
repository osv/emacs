CHECK_NPM_BIN_PROFILE = $(shell grep 'HOME/npm/bin' ~/.profile)
NPM_GLOBAL_PATH       = $(HOME)/npm
TERN_PLUG_DIR         = $(NPM_GLOBAL_PATH)/lib/node_modules/tern/plugin

define PROFILE_NPM

# Autogenerate by ~/emacs/Makefile at "$(shell date)"
if [ -d "$$HOME/npm/bin" ] ; then
    PATH="$$PATH:$(NPM_GLOBAL_PATH)/bin"
fi
# end generete part
endef

export PROFILE_NPM

help:
	@echo "Bootstrap Emacs environment"
	@echo "Usage:"
	@echo "     make all"
	@echo "or"
	@echo "     make apt node cpan tern"
	@echo
	@echo "Note: NPM prefix will be $(NPM_GLOBAL_PATH)"

all: apt node cpan tern

# main targers

apt:
	sudo apt-get install nodejs perl-doc
node: node-setup
	npm install -g jshint jsonlint tern csslint js-beautify

node-setup:
ifeq ($(CHECK_NPM_BIN_PROFILE),)
	@echo "********************************************"
	@echo "I setup NPM prefix to: $(NPM_GLOBAL_PATH)"
	@echo "********************************************"
	mkdir -p $(NPM_GLOBAL_PATH)
	npm config set prefix $(NPM_GLOBAL_PATH)
	echo "$$PROFILE_NPM" >> ~/.profile
	@echo "You need relogin to apply ~/.profile changes globally"
endif
	@echo "npm setup done"
tern:
	curl https://raw.githubusercontent.com/Slava/tern-meteor/master/meteor.js > /tmp/meteor.js
	cp /tmp/meteor.js ${TERN_PLUG_DIR}

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
