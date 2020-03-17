FROM ruby:2.5.0

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

RUN gem install bundler -v 1.17.3

RUN mkdir /app_name
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN bundle _1.17.3_ install
ADD . $APP_ROOT
