FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    node.js \
    mariadb-client \
    yarn

WORKDIR /skilma
COPY Gemfile Gemfile.lock /skilma/
RUN bundle install