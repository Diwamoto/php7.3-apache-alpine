FROM alpine:3.6

MAINTAINER Diwamoto <daiki.work.0118@gmail.com>

ENV PHP_VER 7.3.27

RUN apk update && apk upgrade && apk --no-cache add \
    libressl-dev apache2 apache2-dev wget gcc g++ make libtool ca-certificates libxml2 libxml2-dev autoconf curl curl-dev \
    zlib zlib-dev musl-dev openssh openntpd nano freetype libpng libjpeg-turbo freetype-dev libpng-dev \
    libjpeg-turbo-dev tar openssl apache2-ssl icu-dev libzip-dev build-base icu-libs\
    # PHPのビルド
    && cd /tmp \
    && wget -O php-${PHP_VER}.tar.gz http://jp2.php.net/get/php-${PHP_VER}.tar.gz/from/this/mirror \
    && tar xvfz php-${PHP_VER}.tar.gz \
    && cd php-${PHP_VER} \
    && ./configure --enable-mbstring --with-intl --with-curl=/usr/lib --with-apxs2=/usr/bin/apxs --enable-intl --enable-zip --with-pdo-mysql --with-mysqli --with-openssl --with-curl --with-zlib --with-gd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-zlib=shared --enable-opcache\
    && make && make install \
    # Xdebugのインストール
    && pecl channel-update pecl.php.net \
    && pecl install xdebug-3.0.2\
    # 無駄ファイルを削除
    && rm -rf /tmp/* /var/cache/apk/* \
    && apk del --purge make wget gcc g++ make autoconf

WORKDIR /var/www/html

CMD /usr/sbin/httpd -D FOREGROUND