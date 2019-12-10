FROM alpine:3.10 AS builder

ENV LANG C.UTF-8

RUN apk update
RUN apk upgrade
RUN apk add cabal ghc git musl-dev ncurses-dev ncurses-static zlib-dev

WORKDIR /tmp
RUN git clone --branch 0.19.1 https://github.com/elm/compiler.git .
RUN rm worker/elm.cabal
RUN cabal new-update
RUN cabal new-build

FROM node:lts-alpine3.10
COPY --from=builder /tmp/dist-newstyle/build/x86_64-linux/ghc-8.4.3/elm-0.19.1/x/elm/build/elm/elm /usr/lib/bin
USER node
WORKDIR ~
ENTRYPOINT ["ash"]
