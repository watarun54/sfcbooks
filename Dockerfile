FROM ruby:2.5.0-alpine

RUN mkdir /app_name
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN apk update && \
    apk upgrade && \
    apk add --no-cache nodejs tzdata libxml2-dev curl-dev make gcc libc-dev g++ mariadb-dev imagemagick6-dev && \
    apk add --update --virtual build-dependencies --no-cache build-base curl-dev ruby-dev vim && \
    bundle install -j4
    # apk del build-dependencies

ADD . $APP_ROOT
