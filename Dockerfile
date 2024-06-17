# Use an official Elixir runtime as the base image
FROM elixir:1.14-alpine as builder



ENV MIX_ENV prod

RUN apk add --update --no-cache bash git openssh openssl
RUN apk add --update --no-cache --virtual .gyp g++ make

RUN mix local.hex --force && \
    mix local.rebar --force
    
WORKDIR /api_display

COPY mix.exs mix.lock ./
COPY config config
COPY assets assets
COPY priv priv
COPY lib lib

RUN mix do deps.get --only ${MIX_ENV}, deps.compile
ENV PATH="/root/.mix/escripts:${PATH}"

RUN mix assets.deploy

RUN mix release api_display

# Run Release
FROM alpine:3.14

RUN apk add --update --no-cache bash openssl postgresql-client libstdc++

ENV MIX_ENV prod

EXPOSE 5000

WORKDIR /api_display
COPY --from=builder /api_display/_build/prod/rel/api_display/ .

HEALTHCHECK CMD curl --fail http://localhost:4000/ || exit 1

CMD ["sh", "-c", "/api_display/bin/api_display start"]