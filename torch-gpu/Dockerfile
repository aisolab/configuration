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

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \     
     rm ~/miniconda.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda install python=3.6 jupyter pip=9.0.1
RUN conda install pytorch=1.2.0 torchvision=0.4.0 torchtext=0.4.0 cudatoolkit=10.0 -c pytorch
RUN conda clean -ya 
RUN echo "export PATH=/opt/conda/bin:\$PATH" > /etc/profile.d/conda.sh

RUN pip install scipy scikit-learn pandas cython matplotlib seaborn
RUN pip install future tb-nightly
RUN pip install --upgrade pip
RUN rm -rf ~/.cache/pip

ENV PYTHONUNBUFFERED=1
WORKDIR /root

