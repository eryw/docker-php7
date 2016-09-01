FROM php:7.0

MAINTAINER Ery Widyanto <kristeryw@gmail.com>

RUN set -xe && \
    buildDeps="libpq-dev libicu-dev zlib1g-dev" && \
    apt-get update && \
    apt-get install -y $buildDeps --no-install-recommends && \
    docker-php-ext-install \
        pgsql \
        pdo \
        pdo_pgsql \
        intl \
        zip \
    && \
    pecl install apcu && \
    pecl install xdebug && \
    docker-php-ext-enable apcu && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["php", "-a"]
