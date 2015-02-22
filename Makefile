.PHONY: all \
		clean \
		distclean \
		install

all :
	@echo "Run \`make -n install\` and read the output carefully."
	@echo "If you're happy with what will happen, then run \`make install\`."

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

install-jshint :
	install -m 0644 -- jshint/jshintrc "$(HOME)"/.jshintrc

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
		install-vim-vundle \
		install-vim-plugins

install-gvim : install-vim \
		install-gvim-config

install-vim-config :
	install -m 0644 -- vim/vimrc "$(HOME)"/.vimrc

install-gvim-config :
	install -m 0644 -- vim/gvimrc "$(HOME)"/.gvimrc

install-vim-init:
	install -m 0755 -d -- \
			"$(HOME)"/.vim/bundle \
			"$(HOME)"/.vim/swap \
			"$(HOME)"/.vim/undodir

install-vim-vundle :
	vim/install-vundle

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
