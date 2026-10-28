FROM php:8.3-apache

RUN apt-get update && apt-get install -y libicu-dev libzip-dev unzip git \
 && docker-php-ext-install intl mysqli pdo_mysql zip \
 && a2enmod rewrite

# Document root diarahkan ke folder public CodeIgniter
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
 && sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Samakan UID www-data dengan user WSL (1000) agar file bisa diedit dari host
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
ENV COMPOSER_HOME=/tmp/composer
WORKDIR /var/www/html
