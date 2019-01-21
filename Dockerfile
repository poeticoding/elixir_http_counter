FROM elixir:1.8.0-alpine

WORKDIR /app

ADD ./config /app/config
ADD ./lib /app/lib

ADD ./mix.exs /app/mix.exs
ADD ./mix.lock /app/mix.lock

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix compile

ENV PORT 4000 

CMD ["iex","--sname","counter","--cookie","secret_cookie","-S","mix"]