FROM ruby:2.5

ENV RAILS_ROOT /var/www/apollo
ENV RAILS_ENV staging
RUN mkdir -p $RAILS_ROOT

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

#Create a user so docker don't run the container commands as root
RUN groupadd -g 1000 apollo && \
    useradd -r -u 1000 -g apollo apollo

RUN apt-get update -qq && apt-get install -y postgresql-client nodejs vim

#RUN GEMFILE
COPY ./apollo/Gemfile Gemfile
COPY ./apollo/Gemfile.lock Gemfile.lock

RUN bundle install --jobs 20 --retry 5 --without development test

#ADD PROJECT FILES
COPY ./apollo .
#COPY database.yml ./config/database.yml
#COPY application.yml ./config/application.yml
#COPY staging.log ./log/staging.log

#INSTALL PASSENGER
RUN passenger-install-nginx-module --auto-download --auto --prefix=/opt/nginx

#RUN bundle exec rake assets:precompile

ADD nginx.conf /opt/nginx/conf/nginx.conf

EXPOSE 8000
EXPOSE 580