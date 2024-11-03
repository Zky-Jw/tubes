FROM php:8.3-fpm

# Copy composer.json dan composer.lock terlebih dahulu
COPY composer.* /var/www/laraveldocker/

# Set working directory
WORKDIR /var/www/laraveldocker

# Update repository dan install paket yang diperlukan
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    mariadb-client \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    vim \
    unzip \
    git \
    curl \
    libzip-dev \
    zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install ekstensi PHP
RUN docker-php-ext-install pdo pdo_mysql gd zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Buat grup dan pengguna
RUN groupadd -g 1000 www && \
    useradd -u 1000 -g www -s /bin/bash www

# Copy semua file aplikasi ke dalam container
COPY . .

# Ubah kepemilikan direktori kerja
RUN chown -R www:www /var/www/laraveldocker

USER www

EXPOSE 9000

CMD ["php-fpm"]
