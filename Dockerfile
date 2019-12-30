FROM alpine:3 AS builder

RUN apk add --update cabal ghc musl-dev ncurses-dev ncurses-static wget zlib-dev zlib-static

WORKDIR /tmp

RUN apk add git
ARG branch
RUN git clone -b ${branch} --bare https://github.com/elm/compiler.git
RUN rm worker/elm.cabal

RUN cabal new-update
RUN cabal new-build --ghc-option=-optl=-static --enable-split-sections --enable-executable-stripping

FROM scratch
COPY --from=builder /tmp/elm/dist-newstyle/build/*-linux/ghc-*/elm-*/x/elm/build/elm/elm /
CMD ["/elm"]
