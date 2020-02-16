FROM alpine:edge

MAINTAINER Diwamoto <daiki.work.0118@gmail.com>

RUN apk update && apk upgrade && apk add \
	bash musl-dev apache2 php7 php7-apache2 ca-certificates openssh tzdata openntpd nano \
    php7-phar php7-iconv php7-ftp php7-openssl php7-pear php7-dev php7-mcrypt php7-mbstring \
    php7-dom php7-pdo php7-zip php7-json php7-sqlite3 php7-pdo_pgsql \
    php7-pdo_mysql php7-pdo_sqlite php7-xml php7-sodium\
    php7-xmlreader php7-xmlwriter php7-tokenizer php7-curl \
    php7-ctype php7-session php7-posix php7-intl php7-fileinfo php7-simplexml \
    freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
    && mkdir -p /run/apache2 \
    && cp /usr/bin/php7 /usr/bin/php \
    && rm -rf /tmp/* /var/cache/apk/* 

WORKDIR /var/www/html

CMD /usr/sbin/httpd -D FOREGROUND