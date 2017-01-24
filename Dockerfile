# # FROM rails:5.0.0.1
# # RUN mkdir /myapp
# # WORKDIR /myapp
# # ADD Gemfile /myapp/Gemfile
# # ADD Gemfile.lock /myapp/Gemfile.lock
# # RUN bundle install
# # ADD . /myapp
# # Base image
# FROM ubuntu:16.04
# # FROM rails:5.0.0.1
#
# ENV IPM_APP /home/rails/webapp
#
# ENV RAILS_ENV production
#
# # Install PGsql dependencies and js engine
# RUN apt-get update
# # RUN apt-get install -y build-essential
# # RUN apt-get install -y libpq-dev
# # RUN apt-get install -y nodejs
# # RUN apt-get install -y libxml2-dev libxml2 zlib1g-dev libxslt-dev
# RUN apt-get install -y curl
# RUN apt-get install -y git
# RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.3
# # RUN echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile
# RUN echo "source $HOME/.rvm/scripts/rvm" >> ~/.bashrc
# # RUN /bin/bash -c "rvm install 2.3.3"
# RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm"
# RUN /bin/bash -l -c "gem install bundler"
# # RUN /bin/bash -l -c "gem install rails -v '4.2'"
#
# RUN apt-get install -y libpq-dev
# RUN apt-get install -y nodejs
#
# WORKDIR $IPM_APP
#
# # Install gems
# ADD Gemfile* $IPM_APP/
# # RUN gem install nokogiri -v '1.6.8.1'
# # RUN gem install nokogiri -v '1.7.0.1'
# # RUN gem install bcrypt -v '3.1.11'
# # RUN gem install nio4r -v '2.0.0'
# # RUN gem install ffi -v '1.9.17'
# # RUN gem install json -v '2.0.3'
# # RUN bundle install --deployment
# RUN /bin/bash -l -c "bundle install"
#
# # Add the app code
# ADD . $IPM_APP
#
# # compile assets
# RUN /bin/bash -l -c "rake assets:precompile"
#
# # Default command
# CMD ["rails", "s", "-b", "0.0.0.0"]

# Base image
# FROM ubuntu:16.04
FROM rails:5.0.0.1

ENV IPM_APP /home/rails/webapp

ENV RAILS_ENV production

# Install PGsql dependencies and js engine
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y libpq-dev
RUN apt-get install -y nodejs
RUN apt-get install -y libxml2-dev libxml2 zlib1g-dev libxslt-dev
RUN apt-get install -y curl
RUN apt-get install -y git
# RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.3
# # RUN echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile
# RUN echo "source $HOME/.rvm/scripts/rvm" >> ~/.bashrc
# RUN /bin/bash -c "rvm install 2.3.3"
# RUN /bin/bash -c "source /usr/local/rvm/scripts/rvm"
# RUN /bin/bash -l -c "gem install bundler"
# RUN /bin/bash -l -c "gem install rails -v '5.0.0.1'"

WORKDIR $IPM_APP

# Install gems
ADD Gemfile* $IPM_APP/
# RUN gem install nokogiri -v '1.6.8.1'
# RUN gem install nokogiri -v '1.7.0.1'
# RUN gem install bcrypt -v '3.1.11'
# RUN gem install nio4r -v '2.0.0'
# RUN gem install ffi -v '1.9.17'
# RUN gem install json -v '2.0.3'
# RUN bundle install --deployment
# RUN /bin/bash -l -c "bundle install"
RUN bundle install

# Add the app code
ADD . $IPM_APP

# compile assets
RUN rake assets:precompile

# Default command
CMD ["rails", "s", "-b", "0.0.0.0"]
