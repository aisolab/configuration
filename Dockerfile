FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
MAINTAINER bsk0130@gmail.com

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
      apt-get install -y sudo apt-utils make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl git

RUN adduser --disabled-password --gecos "" appuser
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
RUN pyenv install 3.7.7
RUN pyenv global 3.7.7
RUN pyenv rehash
