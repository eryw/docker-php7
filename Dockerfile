FROM debian:stretch

LABEL maintainer="kristeryw@gmail.com"

RUN apt-get update && \
    apt-get install -y wget apt-transport-https lsb-release ca-certificates && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    apt-get update && \
    DEBIAN_FRONTEND='noninteractive' apt-get install -y \
        php7.1-cli \
        php7.1-gd \
        php7.1-gmp \
        php7.1-mysql \
        php7.1-pgsql \
        php7.1-sqlite3 \
        php7.1-mbstring \
        php7.1-opcache \
        php7.1-readline \
        php7.1-xml \
        php7.1-xmlrpc \
        php7.1-soap \
        php7.1-json \
        php7.1-intl \
        php7.1-zip \
        php7.1-bz2 \
        php-gearman \
        php-xdebug \
        php-apcu \
    && \
    sed -i 's/zend_extension=/;zend_extension=/g' /etc/php/7.1/mods-available/xdebug.ini && \
    echo "xdebug.remote_enable = On\nxdebug.max_nesting_level = 256\nxdebug.overload_var_dump = 2\nxdebug.var_display_max_depth = 7" >> /etc/php/7.1/mods-available/xdebug.ini && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-php-entrypoint /usr/local/bin/

ENTRYPOINT ["docker-php-entrypoint"]

CMD ["php", "-a"]
