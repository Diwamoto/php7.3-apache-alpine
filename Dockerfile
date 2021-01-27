FROM php:7.3-alpine

MAINTAINER Diwamoto <daiki.work.0118@gmail.com>

RUN apk update && apk upgrade && apk add \
	bash musl-dev apache2 ca-certificates openssh tzdata openntpd nano \
    freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
    && mkdir -p /run/apache2 \
    && rm -rf /tmp/* /var/cache/apk/* 

WORKDIR /var/www/html

CMD /usr/sbin/httpd -D FOREGROUND