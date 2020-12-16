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
install : install-dotjs \
	install-git \
	install-gpg \
	install-python \
	install-readline \
	install-ripgrep \
	install-vim \
	install-zsh

install-ack :
	cp -p -- ack/ackrc "$(HOME)"/.ackrc

install-bash :
	cp -p -- bash/bashrc "$(HOME)"/.bashrc
	cp -p -- bash/bash_profile "$(HOME)"/.bash_profile

install-dotjs :
	mkdir -p -- "$(HOME)"/.js
	cp -p -- dotjs/*.js "$(HOME)"/.js

create-gitconfig:
	git/setup

install-git : create-gitconfig
	cp -p -- git/gitconfig "$(HOME)"/.gitconfig
	cp -p -- git/gitignore-global "$(HOME)"/.gitignore-global
	mkdir -p -- "$(HOME)"/.local/bin
	cp -p -- git/git-* "$(HOME)"/.local/bin

install-gpg :
	mkdir -p -- "$(HOME)"/.gnupg
	cp -p -- gpg/gpg-agent.conf "$(HOME)"/.gnupg/gpg-agent.conf

install-eslint :
	cp -p -- eslint/eslintrc "$(HOME)"/.eslintrc

install-lein :
	mkdir -p -- "$(HOME)"/.lein
	cp -p -- lein/profiles.clj "$(HOME)"/.lein/profiles.clj

install-python :
	cp -p -- python/pythonrc "$(HOME)"/.pythonrc

install-readline :
	cp -p -- readline/inputrc "$(HOME)"/.inputrc

install-tarsnap :
	cp -p -- tarsnap/tarsnaprc "$(HOME)"/.tarsnaprc

configure-tarsnap :
	ln -s "$(HOME)"/.tarsnaprc /var/root/.tarsnaprc

install-tarsnap-acts :
	cp -p -- tarsnap/acts.conf /usr/local/etc/acts.conf

configure-tarsnap-acts : configure-tarsnap-acts-launch-daemon \
	configure-tarsnap-acts-newsyslog

configure-tarsnap-acts-launch-daemon :
	cp -p -- tarsnap/com.thomasupton.tarsnap-acts.plist /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist
	launchctl unload /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist && launchctl load -w /Library/LaunchDaemons/com.thomasupton.tarsnap-acts.plist

configure-tarsnap-acts-newsyslog :
	cp -p -- tarsnap/com.thomasupton.tarsnap-acts.conf /etc/newsyslog.d/com.thomasupton.tarsnap-acts.conf
	newsyslog -nvv -f /etc/newsyslog.d/com.thomasupton.tarsnap-acts.conf

install-textmate :
	cp -p -- TextMate/tm_properties "$(HOME)"/.tm_properties

install-tmux :
	cp -p -- tmux/tmux.conf "$(HOME)"/.tmux.conf
	mkdir -p -- "$(HOME)"/.tmuxinator
	cp -p -- tmux/tmuxinator/* "$(HOME)"/.tmuxinator

install-vim : install-vim-config \
	install-vim-init \
	install-vim-plug \
	install-vim-plugins \
	install-vim-plugin-config

install-gvim : install-vim \
	install-gvim-config

install-vim-config :
	cp -p -- vim/vimrc "$(HOME)"/.vimrc

install-gvim-config :
	cp -p -- vim/gvimrc "$(HOME)"/.gvimrc

install-vim-init:
	mkdir -p -- \
		"$(HOME)"/.vim/autoload \
		"$(HOME)"/.vim/swap \
		"$(HOME)"/.vim/undodir \
		"$(HOME)"/.vim/plugged

install-vim-plug :
	vim/install-vim-plug

install-vim-plugins :
	vim/install-plugins

install-vim-plugin-config :
	cp -p -- vim/coc-settings.json "$(HOME)"/.vim/coc-settings.json

install-zsh : install-zsh-config \
	install-oh-my-zsh

install-zshd :
	mkdir -p -- "$(HOME)"/.zshrc.d
	cp -p -- zsh/zshrc.d/* "$(HOME)"/.zshrc.d

install-zsh-config : install-zshd
	cp -p -- zsh/zshrc "$(HOME)"/.zshrc

install-oh-my-zsh :
	zsh/install-oh-my-zsh

install-xdg-config :
	mkdir -p -- "$(HOME)"/.config

install-karabiner-elements : install-xdg-config
	cp -p -- Karabiner-Elements/karabiner.json "$(HOME)"/.config/karabiner/karabiner.json

install-ripgrep : install-zsh
	cp -p -- ripgrep/ripgreprc "$(HOME)"/.ripgreprc

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
	@for zsh in zsh/zshrc zsh/zshrc.d/*.zsh git/git-* ; do \
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
