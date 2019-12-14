FROM alpine:latest AS builder

RUN apk add --update cabal ghc git musl-dev ncurses-dev ncurses-static wget zlib-dev

WORKDIR /usr/local/src
RUN git clone https://github.com/elm/compiler.git elm
WORKDIR /usr/local/src/elm
RUN rm worker/elm.cabal
RUN cabal new-update
RUN cabal new-build --enable-split-sections
RUN cp /usr/local/src/elm/dist-newstyle/build/*-linux/ghc-*/elm-*/x/elm/build/elm/elm /usr/local/bin/
CMD ["elm"]
