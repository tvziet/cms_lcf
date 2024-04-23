# Use Ruby 2.7.3 alpine as the base image
FROM ruby:2.7.3-alpine

# Install necessary dependencies for PostgreSQL and other packages
RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    nodejs \
    yarn \
    tzdata && \
    rm -rf /var/cache/apk/*

RUN mkdir /app

# Copy the Gemfile and Gemfile.lock into the Docker image
COPY Gemfile Gemfile.lock ./

# Set the working directory in the container
WORKDIR /app

# Install gems
RUN bundle install

# Copy the rest of the application into the working directory
COPY . ./

# Expose port 3001 for the application
EXPOSE 3001

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0"]