FROM alpine:3.6

MAINTAINER Diwamoto <daiki.work.0118@gmail.com>

RUN apk update && apk upgrade && apk --no-cache add \
    libressl-dev apache2 apache2-dev wget gcc g++ make ca-certificates libxml2 libxml2-dev autoconf curl curl-dev \
    zlib zlib-dev musl-dev openssh openntpd nano freetype libpng libjpeg-turbo freetype-dev libpng-dev \
    libjpeg-turbo-dev tar openssl apache2-ssl \
    # PHPのビルド
    && cd /tmp \
    && wget -O php-7.3.10.tar.gz http://jp2.php.net/get/php-7.3.10.tar.gz/from/this/mirror \
    && tar xvfz php-7.3.10.tar.gz \
    && cd php-7.3.10 \
    && ./configure --enable-mbstring --with-curl=/usr/lib --with-apxs2=/usr/bin/apxs --with-openssl --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-zlib=shared \
    && make && make install \
    # Xdebugのインストール
    && pecl install xdebug-3.0.2 \
    # 無駄ファイルを削除
    && rm -rf /tmp/* /var/cache/apk/* \
    && apk del --purge make wget gcc g++ make autoconf

WORKDIR /var/www/html

CMD /usr/sbin/httpd -D FOREGROUND