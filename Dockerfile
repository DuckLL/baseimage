FROM phusion/baseimage:master-amd64

ENV TERM screen-256color
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV HOME /root
ENV XDG_CONFIG_HOME /root/.config

CMD ["/sbin/my_init"]

# apt
RUN apt update \
&& apt -y upgrade \
&& apt -y install \
   bash-completion \
   git \
   neovim \
   python3.7-dev \
   tmux \
   wget \
   xsel \

&& cd /tmp \
&& wget https://bootstrap.pypa.io/get-pip.py \
&& python3.7 get-pip.py \

# setup with dotfile
&& git clone https://github.com/DuckLL/dotfile.git --depth 1 ~/dotfile \
&& cd ~/dotfile \
&& ./linux.sh \

# cleanup
&& apt clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
