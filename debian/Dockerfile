ARG TAG=latest
FROM debian:${TAG} AS builder

ENV LANG C.UTF-8

RUN apt-get update
RUN apt-get upgrade
RUN apt-get -y install build-essential curl git libgmp-dev libffi-dev libncurses-dev libtinfo5 zlib1g-dev

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

