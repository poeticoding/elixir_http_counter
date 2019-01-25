FROM elixir:1.8.0


RUN apt-get update -y && \
	apt-get install -y wrk htop

WORKDIR /app


ADD ./config /app/config
ADD ./lib /app/lib

ADD ./mix.exs /app/mix.exs
ADD ./mix.lock /app/mix.lock

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix do deps.get, deps.compile, compile

ENV PORT 4000 

ENV MAX_COUNTERS 1

CMD ["elixir","-pa","_build/prod/consolidated","-S","mix"]