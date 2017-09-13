.PHONY: all \
	clean \
	distclean \
	install \
	list \
	test

all :
	@echo "Run \`make -n install\` and read the output carefully."
	@echo "If you're happy with what will happen, then run \`make install\`."

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

clean :
	@rm -f git/gitconfig

distclean :
	@:
install : install-ack \
	install-git \
	install-lein \
	install-python \
	install-readline \
	install-vim \
	install-zsh

install-ack :
	install -m 0644 -- ack/ackrc "$(HOME)"/.ackrc

install-bash :
	install -m 0644 -- bash/bashrc "$(HOME)"/.bashrc
	install -m 0644 -- bash/bash_profile "$(HOME)"/.bash_profile

install-dotjs :
	install -m 0755 -d -- "$(HOME)"/.js
	install -m 0644 -- dotjs/*.js "$(HOME)"/.js

create-gitconfig:
	git/setup

install-git : create-gitconfig
	install -m 0644 -- git/gitconfig "$(HOME)"/.gitconfig
	install -m 0644 -- git/gitignore-global "$(HOME)"/.gitignore-global
	install -m 0755 -d -- "$(HOME)"/.local/bin
	install -m 0755 -- git/git-* "$(HOME)"/.local/bin

install-eslint :
	install -m 0644 -- eslint/eslintrc "$(HOME)"/.eslintrc

install-jscs :
	install -m 0644 -- jscs/jscsrc "$(HOME)"/.jscsrc

install-lein :
	install -m 0755 -d -- "$(HOME)"/.lein
	install -m 0644 -- lein/profiles.clj "$(HOME)"/.lein/profiles.clj

install-python :
	install -m 0644 -- python/pythonrc "$(HOME)"/.pythonrc

install-readline :
	install -m 0644 -- readline/inputrc "$(HOME)"/.inputrc

install-tarsnap :
	install -m 0644 -- tarsnap/tarsnaprc "$(HOME)"/.tarsnaprc

install-textmate :
	install -m 0644 -- TextMate/tm_properties "$(HOME)"/.tm_properties

install-tmux :
	install -m 0644 -- tmux/tmux.conf "$(HOME)"/.tmux.conf
	install -m 0755 -d -- "$(HOME)"/.tmuxinator
	install -m 0644 -- tmux/tmuxinator/* "$(HOME)"/.tmuxinator

install-vim : install-vim-config \
	install-vim-init \
	install-vim-plug \
	install-vim-plugins

install-gvim : install-vim \
	install-gvim-config

install-vim-config :
	install -m 0644 -- vim/vimrc "$(HOME)"/.vimrc

install-gvim-config :
	install -m 0644 -- vim/gvimrc "$(HOME)"/.gvimrc

install-vim-init:
	install -m 0755 -d -- \
		"$(HOME)"/.vim/autoload \
		"$(HOME)"/.vim/swap \
		"$(HOME)"/.vim/undodir \
		"$(HOME)"/.vim/plugged

install-vim-plug :
	vim/install-vim-plug

install-vim-plugins :
	vim/install-plugins

install-zsh : install-zsh-config \
	install-oh-my-zsh

install-zshd :
	install -m 0755 -d -- "$(HOME)"/.zshrc.d
	install -m 0644 -- zsh/zshrc.d/* "$(HOME)"/.zshrc.d

install-zsh-config : install-zshd
	install -m 0644 -- zsh/zshrc "$(HOME)"/.zshrc

install-oh-my-zsh :
	zsh/install-oh-my-zsh

install-xdg-config :
	install -m 0755 -d -- "$(HOME)"/.config

install-karabiner-elements : install-xdg-config
	install -m 0755 -d -- "$(HOME)"/.config/karabiner/assets/complex_modifications
	install -m 0644 -- Karabiner-Elements/karabiner.json "$(HOME)"/.config/karabiner/karabiner.json
	install -m 0644 -- Karabiner-Elements/caps-lock-to-control.json "$(HOME)"/.config/karabiner/assets/complex_modifications/caps-lock-to-control.json
	install -m 0644 -- Karabiner-Elements/logitech-k350-switch-command-option.json "$(HOME)"/.config/karabiner/assets/complex_modifications/logitech-k350-switch-command-option.json

test : test-setup test-zsh test-bash test-vimrc test-dotjs

test-setup :
	@for setup in git/setup vim/install-* vim/update-* zsh/install-* ; do \
		echo "Parsing $$setup" ; \
		if [ -f "$$setup" ] && ! zsh --no-exec "$$setup" ; then \
			exit 1 ; \
		fi \
	done
	@echo "All setup scripts parsed successfully."

test-zsh :
	@for zsh in zsh/zshrc zsh/zshrc.d/*.zsh ; do \
		echo "Parsing $$zsh" ; \
		if [ -f "$$zsh" ] && ! zsh --no-exec "$$zsh" ; then \
			exit 1 ; \
		fi \
	done
	@echo "All zsh scripts parsed succesfully."

test-bash :
	@for bash in bash/* ; do \
		echo "Parsing $$bash" ; \
		if [ -f "$$bash" ] && ! bash -n "$$bash" ; then \
			exit 1 ; \
		fi \
	done
	@echo "All bash scripts parsed successfully."

test-vimrc :
	@for vim in vim/vimrc vim/gvimrc ; do \
		echo "Linting $$vim" ; \
		if [ -f "$$vim" ] && ! vint --color --style-problem "$$vim" ; then \
			exit 1 ; \
		fi \
	done
	@echo "All vim config files linted successfully."

test-dotjs :
	@npm test || exit 1
	@echo "All dotjs files linted successfully."
