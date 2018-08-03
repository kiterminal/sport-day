FROM ruby:2.5.1

# Install apt based dependencies required to run Rails as well as RubyGems. As the Ruby image itself is based on
# a Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs

# Configure the main working directory. This is the base directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

# Setting env up
ENV RAILS_ENV='production'
ENV RAKE_ENV='production'
ENV PUMA_WORKERS=2
ENV PUMA_MAX_THREADS=16
ENV RAILS_SERVE_STATIC_FILES='true'

# Copy the Gemfile as well as the Gemfile.lock and install the RubyGems. This is a separate step so
# the dependencies will be cached unless changes to one of those two files are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install --jobs 20 --retry 5 --without development test

# Copy the main application.
COPY . ./
RUN bundle exec rake assets:precompile

# Expose port 3000 to the Docker host, so we can access it from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also tell the Rails dev server to bind to all interfaces
# by default.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
