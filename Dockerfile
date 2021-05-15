FROM ruby:3.0.1

RUN bundle config --global frozen 1

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY run.rb config.yml lib ./

EXPOSE 5000

CMD ["ruby", "./run.rb"]