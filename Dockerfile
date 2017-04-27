FROM elixir:1.4.0

RUN apt-get update && apt-get install -y git \ 
                                         build-essential \
                                         erlang-dev \
                                         curl \
                                         postgresql-client \
                                         inotify-tools

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs

RUN mix local.hex --force
RUN mix local.rebar --force

ADD . /webapps/revent_dispatcher
WORKDIR /webapps/revent_dispatcher

RUN useradd -m deplo
RUN chown -R deplo /webapps/revent_dispatcher
RUN npm install
ENV MIX_ENV dev
RUN mix deps.get
RUN mix compile

ENV PORT 4000

CMD mix phoenix.server
