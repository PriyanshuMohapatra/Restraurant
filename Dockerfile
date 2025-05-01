# Step 1: Use the official PHP image with FPM
FROM php:8.1-fpm

# Step 2: Install system dependencies required by Laravel
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip

# Step 3: Set the working directory in the container
WORKDIR /var/www

# Step 4: Copy the existing application files into the container
COPY . .

# Step 5: Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Step 6: Install the PHP dependencies (Laravel dependencies)
RUN composer install --no-dev --optimize-autoloader

# Step 7: Expose port 9000 (used by PHP-FPM)
EXPOSE 9000

# Step 8: Run the PHP-FPM server
CMD ["php-fpm"]
