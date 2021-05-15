FROM ruby:3.0.1

# # RUN bundle config --global frozen 1
RUN sed -i.bak -e 's/SECLEVEL=2/SECLEVEL=1/' /usr/lib/ssl/openssl.cnf

WORKDIR /usr/src/app

COPY Gemfile ./
RUN bundle install

COPY . .
EXPOSE 3000

CMD ["ruby", "./run.rb"]