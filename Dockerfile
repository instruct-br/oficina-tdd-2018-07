FROM ruby:2.5
RUN mkdir /code
WORKDIR /code
ADD Gemfile /code/
ADD Gemfile.lock /code/
RUN bundle config --global frozen 1
RUN bundle install
ADD . /code/
CMD ["bundle", "exec", "rake", "test"]
