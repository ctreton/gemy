FROM php:7.1-apache-stretch
MAINTAINER ctreton <corentintreton@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y bash \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    zlib1g-dev \
    libicu-dev \
    g++ \
    apt-transport-https \
    mysql-client \
    default-libmysqlclient-dev \
    mysql-common \
    zip \
    unzip \
    libxml2-dev \
    wget \
    gnupg \
    vim \
    git \
    acl \
    cron

RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr

RUN docker-php-ext-configure intl

RUN docker-php-ext-install -j$(nproc) \
    iconv \
    mcrypt \
    bcmath \
    mbstring \
    intl \
    zip \
    pdo_mysql \
    soap \
    gd

# Apache config
RUN a2enmod rewrite ssl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# get node and npm
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs

# get yarn
RUN npm install -g yarn

