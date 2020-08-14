FROM ubuntu:20.04

# prevent tzdata from stalling
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"

RUN apt-get update \
 && apt-get install -y sudo \
                   build-essential \
                   autoconf \
                   automake \
                   autopoint \
                   bison \
                   gperf \
                   texi2html \
                   texinfo \
                   git \
                   make \
                   gcc \
                   libtool \
                   pkg-config \
                   texinfo \
                   help2man \
                   autopoint \
                   check \
                   wbritish \
                   wamerican \
                   libfftw3-dev \
                   csh \
                   curl \
                   bzip2 \
                   rsync \
                   gettext \
                   wget

RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER docker

RUN sudo apt-get update

# taken from https://www.dedunu.info/2020/06/10/ubuntu-20-04-build-coreutils-from-the-source

RUN cd /home/docker

RUN git clone https://www.github.com/coreutils/coreutils.git

RUN cd coreutils && ./bootstrap && ./configure

RUN sudo make install

RUN cd /home/docker

RUN git clone --recursive https://github.com/dspinellis/dgsh.git

RUN cd dgsh && make config && make && sudo make install
