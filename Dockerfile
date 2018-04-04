FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential
ENV APP_HOME /myapp
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install
COPY . $APP_HOME

