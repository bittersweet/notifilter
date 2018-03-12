FROM elixir:1.4.2

ENV DEBIAN_FRONTEND=noninteractive

ENV MIX_ENV="prod"
ENV PORT=4000

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y -q nodejs

RUN echo $(node -v)
RUN echo $(npm -v)

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mkdir /app
WORKDIR /app

# Install Elixir dependencies
ADD mix.* ./
RUN mix local.rebar
RUN mix local.hex --force
RUN mix deps.get

# Install Node Deps
ADD package.json ./
RUN npm install

# Install application
ADD . .
RUN mix compile

# Assets
RUN NODE_ENV=production node_modules/webpack/bin/webpack.js -p --config webpack.production.config.js
RUN mix phoenix.digest

EXPOSE 4000

CMD mix ecto.migrate && mix phoenix.server

