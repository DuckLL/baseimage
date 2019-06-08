FROM phusion/baseimage:master-amd64

ENV TERM screen-256color
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV HOME /root
ENV XDG_CONFIG_HOME /root/.config

CMD ["/sbin/my_init"]

# apt-fast
RUN add-apt-repository --yes ppa:saiarcot895/myppa \
&& apt-get update \
&& apt-get -y install apt-fast \

# apt-get
&& add-apt-repository --yes ppa:neovim-ppa/stable \
&& add-apt-repository --yes ppa:deadsnakes/ppa \
&& apt-fast update \
&& apt-fast -y upgrade \
&& apt-fast -y install \
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
&& apt-fast clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
