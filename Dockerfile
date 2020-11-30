FROM ruby:2.6.6
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    node.js \
    mariadb-client \
    yarn \
    imagemagick \
    vim

WORKDIR /skilma
COPY Gemfile Gemfile.lock /skilma/
RUN bundle install