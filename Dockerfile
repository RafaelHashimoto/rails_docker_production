FROM ruby:2.5

#Create a user so docker don't run the container commands as root
RUN groupadd -g 999 apollo && \
    useradd -r -u 999 -g apollo apollo

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim
RUN gem install rails
RUN gem install passenger
RUN passenger-install-nginx-module --auto-download --auto --prefix=/opt/nginx

ADD ./staging-nginx.conf /opt/nginx/conf/nginx.conf
# kill $(cat /opt/nginx/logs/nginx.pid)
# /opt/nginx/sbin/nginx
# docker rmi image_name
# docker build -t rails_production .
# remove container
# docker kill container_tag

#docker run --rm -it -d -v  /home/hashimoto/my_project/rails/rails_production:/var/www/apollo -p 80:80 --entrypoint /bin/sh --name railsnginx rails_production
#docker exec -it railsnginx /bin/bash
ENV RAILS_ENV staging

EXPOSE 80