FROM ruby:2.6.3-alpine3.9

RUN apk add --no-cache build-base less

RUN mkdir /notifier
WORKDIR /notifier

COPY Gemfile /notifier/
RUN bundle install

COPY . /notifier

CMD ash
