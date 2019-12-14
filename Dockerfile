FROM alpine:latest AS builder

RUN apk add --update cabal ghc git musl-dev ncurses-dev ncurses-static wget zlib-dev

WORKDIR /usr/local/src
RUN git clone https://github.com/elm/compiler.git elm
WORKDIR /usr/local/src/elm
RUN rm worker/elm.cabal
RUN cabal new-update
# --ghc-option=-optl=-static can be replaced by --enable-executable-static for Cabal ^3.0.0
RUN cabal new-build --enable-split-sections --enable-executable-stripping --enable-library-stripping --disable-executable-dynamic --disable-shared --ghc-option=-optl=-static

FROM scratch
COPY --from=builder /usr/local/src/elm/dist-newstyle/build/*-linux/ghc-*/elm-*/x/elm/build/elm/elm /
ENTRYPOINT ["/elm"]
