NODE_VERSION          = v0.12.4
CHECK_PROFILE_EXTRA   = $(shell grep 'HOME/.profile-extra' ~/.profile)
CHECK_BASH_EXTRA      = $(shell grep 'HOME/.bash-extra' ~/.bashrc)
CHECK_XDEFAULTS_EXTRA = $(shell grep '^\s*#include ".Xdefaults-extra"' ~/.Xdefaults)
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

# next heredoc will be included to .profile
define BASH_INLUDE

# Autogenerate by ~/emacs/Makefile at "$(shell date)"
# additional setup, like PATH for node, less colorize
if [ -n "$$HOME/.bash-extra" ] ; then
    . "$$HOME/.bash-extra"
fi
# end generete part
endef

export BASH_INLUDE

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

# color: https://gist.github.com/vmrob/8924878 http://vmrob.com/colorized-makefiles/
NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m

OK_STRING=$(OK_COLOR)[OK]$(NO_COLOR)
ERROR_STRING=$(ERROR_COLOR)[ERRORS]$(NO_COLOR)
WARN_STRING=$(WARN_COLOR)[WARNINGS]$(NO_COLOR)

AWK_CMD = awk '{ printf "%-30s %-10s\n",$$1, $$2; }'
PRINT_ERROR = printf "$@ $(ERROR_STRING)\n" | $(AWK_CMD) && printf "$(CMD)\n$$LOG\n" && false
PRINT_WARNING = printf "$@ $(WARN_STRING)\n" | $(AWK_CMD) && printf "$(CMD)\n$$LOG\n"
PRINT_OK = printf "$@ $(OK_STRING)\n" | $(AWK_CMD)
BUILD_CMD = LOG=$$($(CMD) 2>&1) ; if [ $$? -eq 1 ]; then $(PRINT_ERROR); elif [ "$$LOG" != "" ] ; then $(PRINT_WARNING); else $(PRINT_OK); fi;