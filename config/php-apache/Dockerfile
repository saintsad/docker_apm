# 1. Base 스테이지
FROM php:8.2-apache AS base

ENV TZ=Asia/Seoul

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN usermod -u ${USER_ID} www-data && groupmod -g ${GROUP_ID} www-data

# [수정] Redis 사용을 위해 pecl install redis 추가
RUN apt-get update && \
  apt-get install -y \
  locales \
  tzdata \
  libonig-dev \
  libzip-dev \
  libpng-dev \
  libjpeg-dev \
  libfreetype6-dev \
  supervisor \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install pdo pdo_mysql mysqli gd zip opcache \
  && pecl install redis \
  && docker-php-ext-enable redis \
  && rm -rf /var/lib/apt/lists/*

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
  && rm composer-setup.php

RUN a2enmod rewrite
RUN a2enmod remoteip

RUN echo "RemoteIPHeader CF-Connecting-IP" >> /etc/apache2/apache2.conf

COPY vhost.conf /etc/apache2/sites-available/000-default.conf

WORKDIR /var/www/html

# ==========================================
# 2. Development 스테이지 (로컬 개발용)
# ==========================================
FROM base AS development

# Xdebug 설치 (디버깅용)
# RUN pecl install xdebug && docker-php-ext-enable xdebug

# 개발 시에는 소스 코드를 복사하지 않고 Volume 마운트를 사용하므로 추가 작업 불필요
# Apache는 기본적으로 root로 실행되어 포트를 열고 자식 프로세스를 www-data로 내립니다.
# USER www-data 로 변경 시 Apache 실행 권한 에러가 날 수 있으므로 생략합니다.

# ==========================================
# 3. Production 스테이지 (운영 서버 배포용)
# ==========================================
FROM base AS production

# OPcache 설정 추가 (성능 최적화)
# COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# 운영용 소스 코드 내장 (빌드 시점에 포함)
# COPY --chown=www-data:www-data ./src /var/www/html

# 보안을 위해 불필요한 도구 제거 및 권한 강화
# RUN chmod -R 755 /var/www/html