FROM elixir:1.9

ENV DEBIAN_FRONTEND=noninteractive

ENV MIX_ENV="prod"
ENV PORT=4000

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - && \
    apt-get install -yq --no-install-recommends nodejs

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /app
WORKDIR /app

# Install Elixir dependencies
ADD mix.* ./
RUN mix local.rebar && \
    mix local.hex --force && \
    mix deps.get

# Install Node Deps
ADD package.json ./
RUN npm install

# Install application
ADD . .
RUN mix compile

# Assets
RUN NODE_ENV=production node_modules/webpack/bin/webpack.js -p --config webpack.production.config.js && \
    mix phoenix.digest

EXPOSE 4000

CMD mix phoenix.server

