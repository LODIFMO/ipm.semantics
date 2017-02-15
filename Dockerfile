# Base image
FROM rails:5.0.0.1

# Config app directory
RUN mkdir /myapp
WORKDIR /myapp

# Install gems
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# Add project
ADD . /myapp
