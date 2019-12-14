ARG TAG=latest

FROM centos:${TAG} AS builder

RUN yum -y update
RUN yum -y upgrade
RUN yum -y install coreutils-single gcc gcc-c++ git gmp-devel make ncurses-devel ncurses-compat-libs zlib-devel

ENV BOOTSTRAP_HASKELL_NONINTERACTIVE true
ENV PATH /root/.ghcup/bin:${PATH}
RUN curl https://get-ghcup.haskell.org -sSf | sh

WORKDIR /usr/local/src
RUN git clone https://github.com/elm/compiler.git elm
WORKDIR /usr/local/src/elm
RUN rm worker/elm.cabal
RUN cabal update
RUN cabal build --enable-split-sections
RUN cp /usr/local/src/elm/dist-newstyle/build/*-linux/ghc-*/elm-*/x/elm/build/elm/elm /usr/local/bin/
CMD ["elm"]
