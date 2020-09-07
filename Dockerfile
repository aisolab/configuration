FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
MAINTAINER bsk0130@gmail.com

#ENV TZ=Asia/Seoul
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
      apt-get install -y sudo apt-utils make build-essential \
      libssl-dev zlib1g-dev libbz2-dev libreadline-dev\
      libsqlite3-dev wget curl git libffi-dev liblzma-dev locales

RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
RUN adduser --disabled-password --gecos "" appuser --uid 1001
RUN adduser appuser sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER appuser
WORKDIR /home/appuser

# pyenv 설치/ 설정
ENV HOME /home/appuser
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN git clone https://github.com/pyenv/pyenv.git .pyenv

# python 설치
RUN pyenv install 3.8.5
RUN pyenv global 3.8.5
RUN pyenv rehash

# WORKDIR 설정
WORKDIR /home/appuser/workspace