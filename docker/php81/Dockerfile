FROM php:8.1-fpm

ARG debug

RUN apt-get update && apt-get install -y \
    gnupg \
    wget \
    lsb-release \
    libfreetype6 \
    libfreetype6-dev

RUN echo "deb https://deb.debian.org/debian stretch main" >> /etc/apt/sources.list

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list

RUN apt-get update && apt-get install -y \
        gcc \
        make \
        git \
        curl \
        gnupg \
        msmtp \
        graphviz \
        libc-dev \
        autoconf \
        libpq-dev \
        libpng-dev \
        libwebp-dev \
        libxml2-dev \
        pkg-config \
        libssl-dev \
        libzip-dev \
        libonig-dev \
        libjpeg-dev \
        libmemcached-dev \
        postgresql-client-13 \
    && docker-php-ext-configure gd \
        --with-jpeg=/usr/include \
        --with-freetype=/usr/include \
        --with-webp=/usr/include \
    && docker-php-ext-configure calendar \
    && docker-php-ext-install -j$(nproc) \
        gd \
        zip \
        soap \
        pgsql \
        mysqli \
        opcache \
        calendar \
        pdo_mysql \
        pdo_pgsql \
    && pecl install \
        memcached \
        redis \
    && docker-php-ext-enable \
        memcached \
        redis

RUN if [ "$debug" = "true" ] ; then pecl install \
        xdebug \
    && docker-php-ext-enable \
        xdebug ;fi

RUN apt-get clean \
    && docker-php-source delete \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/cache/apt/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS -L -o phive.phar "https://phar.io/releases/phive.phar" \
    && curl -sS -L -o phive.phar.asc "https://phar.io/releases/phive.phar.asc" \
    && gpg --keyserver hkps://keys.openpgp.org --recv-keys 0x6AF725270AB81E04D79442549D8A98B29B2D5D79 \
    && gpg --verify phive.phar.asc phive.phar 2>/dev/null \
    && rm phive.phar.asc \
    && chmod +x phive.phar \
    && mv phive.phar /usr/local/bin/phive

RUN usermod -u 1000 www-data

WORKDIR /var/www

EXPOSE 9000
EXPOSE 9003

CMD ["php-fpm"]
