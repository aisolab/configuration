FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04
LABEL maintainer "Boseop Kim <bsk0130@gmail.com>"

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo "XKBMODEL=\"pc105\"\n \
          XKBLAYOUT=\"us\"\n \
          XKBVARIANT=\"\"\n \
          XKBOPTIONS=\"\"" > /etc/default/keyboard

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         libjpeg-dev \
         libpng-dev \
         sudo \
         apt-utils \
         man \
         tmux \
         less \
         wget \
         iputils-ping \
         zsh \
         htop \
         software-properties-common \
         tzdata \
         locales \
         openssh-server \
         xauth \
         rsync &&\
     rm -rf /var/lib/apt/lists/*

RUN locale-gen ko_KR.UTF-8
ENV LANG="ko_KR.UTF-8" LANGUAGE="ko_KR:en" LC_ALL="ko_KR.UTF-8"
WORKDIR /root

