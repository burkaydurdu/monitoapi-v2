# Monitoapi application docker file

# This is our dependency
FROM ruby:2.5.8

# install application files
RUN mkdir -p /src
COPY Gemfile Gemfile.lock /src/
WORKDIR /src

ENV LANG C.UTF-8

# Install our dependencies
ENV BUNDLER_VERSION 2.1.4
RUN gem install bundler
RUN bundle install

COPY . /src
