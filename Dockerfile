# A basic apache server. To use either add or bind mount content under /var/www
FROM ubuntu:16.04

MAINTAINER Tom Scofield version: 0.1

RUN apt-get update && apt-get install -y apache2 git && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/local/; git clone https://github.com/tscofield/ical-to-google-calendar.git

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2


EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
