FROM debian:stable AS builder

ENV LANG C.UTF-8

RUN apt-get update
RUN apt-get upgrade
RUN apt-get -y install git haskell-platform

WORKDIR /usr/local/src
RUN git clone https://github.com/elm/compiler.git elm
WORKDIR /usr/local/src/elm
RUN rm worker/elm.cabal
RUN cabal new-update
RUN cabal new-build --enable-split-sections
RUN cp /usr/local/src/elm/dist-newstyle/build/*-linux/ghc-*/elm-*/x/elm/build/elm/elm /usr/local/bin/
CMD ["elm"]
