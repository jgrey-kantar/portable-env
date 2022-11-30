FROM alpine:latest

RUN apk add -U --no-cache \
    neovim git zsh tmux \
    openssh-client bash \
    curl less man ncurses\ 
    python3 pyenv \
    docker py-pip

RUN pip install docker-compose

RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

COPY zshrc .zshrc
COPY vimrc .config/nvim/init.vim
COPY tmux.conf .tmux.conf

# Install Vim Plug for plugin management
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
RUN nvim +PlugInstall +qall >> /dev/null
# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm
# Install plugins
RUN .tmux/plugins/tpm/bin/install_plugins

# Create a dev user
RUN useradd -ms /bin/zsh dev

# Do everything from now on in the created users home directory
WORKDIR /home/dev
ENV HOME /home/dev

# Entrypoint script does switches u/g ID's and `chown`s everything
COPY entrypoint.sh /bin/entrypoint.sh
# Set working directory to /workspace
WORKDIR /workspace 
# Default entrypoint, can be overridden
CMD ["/bin/entrypoint.sh"]