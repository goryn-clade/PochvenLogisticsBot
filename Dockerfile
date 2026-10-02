FROM ruby:4.0-slim

RUN bundle config set --global frozen 1

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["ruby", "./run.rb"]
