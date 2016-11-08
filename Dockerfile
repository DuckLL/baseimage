FROM phusion/baseimage:latest

MAINTAINER DuckLL <a347liao@gmail.com>

ENV TERM screen-256color
ENV LC_ALL en_US.UTF-8

CMD ["/sbin/my_init"]

# apt-fast
RUN add-apt-repository --yes ppa:apt-fast/stable \
&& apt-get update \
&& apt-get -y install apt-fast

# apt-get
RUN add-apt-repository --yes ppa:neovim-ppa/unstable \
&& apt-fast update \
&& apt-fast upgrade -y \
&& apt-fast install -yq \
   bash-completion \
   git \
   neovim \
   python-pip \
   python3-pip \
   tmux \
   wget \
&& apt-fast clean

# pip
RUN pip2 install --upgrade pip \
&& pip2 install \
   neovim \
&& pip3 install --upgrade pip \
&& pip3 install \
   neovim

# dotfiles
RUN git clone https://github.com/DuckLL/baseimage.git --depth 1 ~/conf \
&& cp ~/conf/.tmux.conf ~/.tmux.conf \
&& cp ~/conf/.vimrc ~/.vimrc \
&& mkdir -p ~/.config/nvim \
&& ln -s ~/.vimrc ~/.config/nvim/init.vim \
&& echo 'alias vim="nvim"' >> ~/.bashrc

# vim plugin
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
&& nvim +PlugInstall +q +UpdateRemotePlugins +q
