ARG ELIXIR="1.15.4"
ARG ERLANG="26.0.2"
ARG DEBIAN="bookworm-20230612-slim"
ARG OS="debian-${DEBIAN}"
FROM "hexpm/elixir:${ELIXIR}-erlang-${ERLANG}-${OS}" as builder
# Base image

WORKDIR /todo

ENV MIX_ENV="prod"
# Uses prod mix env by default

RUN mix local.hex --force && mix local.rebar --force
# Install build tools

COPY mix.exs mix.lock ./
COPY config config
COPY lib lib
# Copies the required source files

RUN mix deps.get --only prod
# Fetches prod deps

RUN mix release
# Builds the release

FROM debian:${DEBIAN}
# Base image

WORKDIR "/todo"

RUN apt-get update -y && apt-get install -y openssl locales

COPY \
    --from=builder \
    --chown=nobody:root \
    /todo/_build/prod/rel/todo ./
# Copies the built release

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"
ENV LC_ALL="en_US.UTF-8"

CMD ["/todo/bin/todo", "start_iex"]
# Defines the start command