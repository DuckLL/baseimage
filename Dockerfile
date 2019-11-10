FROM phusion/baseimage:master-amd64

ENV TERM screen-256color
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV HOME /root
ENV XDG_CONFIG_HOME /root/.config

COPY ./sshd_config /etc/ssh/sshd_config

CMD ["/sbin/my_init"]

# apt
RUN apt-add-repository ppa:neovim-ppa/stable \
&& apt update \
&& apt -y upgrade \
&& apt -y install \
   bash-completion \
   git \
   neovim \
   python3-distutils \
   tmux \
   wget \
   xsel \

&& cd /tmp \
&& wget https://bootstrap.pypa.io/get-pip.py \
&& python3 get-pip.py \

# setup with dotfile
&& git clone https://github.com/DuckLL/dotfile.git --depth 1 \
&& cd dotfile \
&& ./linux.sh \

# set vim
&& pip3 install pip -U --user \
&& pip3 install pynvim --user \
&& curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
&& nvim +PlugInstall +q +UpdateRemotePlugins +q \

# cleanup
&& apt clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/service/sshd/down
