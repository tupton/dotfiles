.PHONY: all \
		clean \
		distclean \
		install \
		install-ack \
		install-bash \
		install-git \
		install-jshint \
		install-python \
		install-readline \
		install-tarsnap \
		install-textmate \
		install-tmux \
		install-zsh \
		install-oh-my-zsh

all :
	@echo "Run \`make -n install\` and read the output carefully."
	@echo "If you're happy with what will happen, then run \`make install\`."

clean :
	@:

distclean :
	@:

install : install-ack \
		install-bash \
		install-git \
		install-python \
		install-readline \
		install-tmux \
		install-vim \
		install-zsh

install-ack :
	install -m 0644 -- ack/ackrc "$(HOME)"/.ackrc

install-bash :
	install -m 0644 -- bash/bashrc "$(HOME)"/.bashrc
	install -m 0644 -- bash/bash_profile "$(HOME)"/.bash_profile

install-git :
	install -m 0644 -- git/gitconfig "$(HOME)"/.gitconfig
	install -m 0644 -- git/gitignore-global "$(HOME)"/.gitignore-global

install-jshint :
	install -m 0644 -- jshint/jshintrc "$(HOME)"/.jshintrc

install-python :
	install -m 0644 -- python/pythonrc "$(HOME)"/.pythonrc

install-readline :
	install -m 0644 -- readline/inputrc "$(HOME)"/.inputrc

install-tarsnap :
	install -m 0644 -- tarsnap/tarsnaprc "$(HOME)"/.tarsnaprc

install-texmate :
	install -m 0644 -- TextMate/tm_properties "$(HOME)"/.tm_properties

install-tmux :
	install -m 0644 -- tmux/tmux.conf "$(HOME)"/.tmux.conf
	install -m 0755 -d -- "$(HOME)"/.tmuxinator
	install -m 0644 -- tmux/tmuxinator/* "$(HOME)"/.tmuxinator

install-zsh : install-zsh-config \
		install-oh-my-zsh

install-zsh-config :
	install -m 0644 -- zsh/zshrc "$(HOME)"/.zshrc

install-oh-my-zsh :
	if [ ! -d "$(HOME)"/.oh-my-zsh ]; then \
		git clone https://github.com/robbyrussell/oh-my-zsh.git "$(HOME)"/.oh-my-zsh; \
	fi
