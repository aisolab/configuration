FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
MAINTAINER bsk0130@gmail.com

RUN apt-get update && \
      apt-get install -y sudo apt-utils make build-essential \
      libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
      libsqlite3-dev wget curl git libffi-dev liblzma-dev locales \
      g++ openjdk-8-jdk openssh-server

RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ARG UID
RUN adduser --disabled-password --gecos "" user --uid ${UID:-1000}
RUN adduser user sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER user
WORKDIR /home/user

# pyenv 설치/ 설정
ENV HOME /home/user
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN git clone https://github.com/pyenv/pyenv.git .pyenv

# python 설치
SHELL ["/bin/bash", "-c"]
RUN pyenv install 3.7.9 && \
	pyenv global 3.7.9

RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# WORKDIR 설정
WORKDIR /home/user/workspace

# openssh-server 설정
ARG PASSWD
RUN echo user:${PASSWD:-hephaestus} | sudo chpasswd
RUN sudo sed -i 's_/usr/lib/openssh/sftp-server_internal-sftp_g' /etc/ssh/sshd_config
RUN echo "sudo service ssh start" > /home/user/.bashrc

# pyenv 추가 설정
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc
