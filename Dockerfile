FROM ruby:3.0.3

ENV APP_ROOT=/usr/src/app
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

RUN apt-get update && \
    apt-get -y install build-essential \
                       libpq-dev \
                       nodejs \
                       default-mysql-client \
                       imagemagick \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ADD Gemfile $APP_ROOT
ADD Gemfile.lock $APP_ROOT

RUN gem update --system
RUN bundle install --system

ADD . $APP_ROOT

EXPOSE 3000
