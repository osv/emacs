TERN_PLUG_DIR=/usr/lib/node_modules/tern/plugin

help:
	@echo "Bootstrap Emacs environment"
	@echo "Usage:"
	@echo "     sudo make all"
	@echo "or"
	@echo "     sudo make apt node cpan tern"

all: apt node cpan tern

# main targers

apt:
	sudo apt-get install nodejs perl-doc
node:
	sudo npm install -g jshint tern csslint js-beautify

tern:
	curl https://raw.githubusercontent.com/Slava/tern-meteor/master/meteor.js > /tmp/meteor.js
	sudo cp /tmp/meteor.js ${TERN_PLUG_DIR}

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
	${CPAN_INSTALL} Perl::Critic
