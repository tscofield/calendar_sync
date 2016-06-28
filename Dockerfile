# A basic apache server. To use either add or bind mount content under /var/www
FROM ubuntu:16.04

MAINTAINER Tom Scofield version: 0.1

RUN apt-get update && apt-get install -y apache2 git ruby ruby-dev bundler && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/bin && cd /usr/local/bin && git clone https://github.com/yvangodard/ical-to-google-calendar.git 
RUN mkdir -p /usr/local/bin && cd /usr/local/bin && git clone https://github.com/yvangodard/icalsync.git
RUN ls -l /usr/local/bin
# install some ruby gems
RUN cd /usr/local/bin/icalsync && bundle install icalsync
#RUN gem install addressable -v '2.3.7'
#RUN gem install coderay -v '1.1.0'
#RUN gem install extlib -v '0.9.16'
#RUN gem install multipart-post -v '2.0.0'
RUN cd /usr/local/bin/icalsync && /usr/local/bin/icalsync/icalsync -h

#Remove git, we only needed it for setup 
RUN apt-get -y remove git && apt-get -y autoremove

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2


EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
