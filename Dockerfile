FROM debian:bullseye-slim
 
ENV NGINX_ROOT=/var/www/html \
  WWWROOT=localhost \
  DATAROOT=/var/lib/moodledata \
  DB_TYPE=mysqli \
  ADMIN_USER=admin \
  FULLNAME=moodle \
  SHORTNAME=moodle

RUN set -ex && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y curl nginx sendmail php7.4-cli php7.4-fpm php7.4-iconv php7.4-mbstring php7.4-curl  \
    php7.4-tokenizer  php7.4-xmlrpc php7.4-soap php7.4-ctype php7.4-zip php7.4-gd php7.4-simplexml php7.4-dom  \
    php7.4-xml php7.4-intl  php7.4-json php7.4-mysql sudo wget && \
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log && \
  rm /etc/nginx/sites-available/default && \
  echo 'security.limit_extensions = .php' >> '/etc/php/7.4/fpm/pool.d/www.conf' && \
  {\
    echo '[global]'; \
    echo 'error_log = /proc/self/fd/2'; \
    echo 'log_limit = 8192'; \
    echo '[www]'; \ 
    echo 'access.log = /proc/self/fd/2'; \ 
    echo 'clear_env = no'; \
    echo 'catch_workers_output = yes'; \
    echo 'decorate_workers_output = no'; \
    echo 'php_admin_flag[log_errors] = on'; \
    echo 'php_admin_flag[display_errors] = off'; \
    echo 'php_admin_value[error_reporting] = E_ALL & ~E_NOTICE & ~E_WARNING & ~E_STRICT & ~E_DEPRECATED'; \
    echo 'php_admin_value[error_log] = /proc/self/fd/2'; \
    } | tee /etc/php/7.4/fpm/pool.d/zzz-php.conf && \
  mkdir -p ${DATAROOT} && \
  chown -R www-data:www-data ${NGINX_ROOT} && \
  chown -R www-data:www-data ${DATAROOT} && \
  chmod -R 755 ${NGINX_ROOT} && \
  chmod -R 755 ${DATAROOT} && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# RUN set -ex && \
#   wget -O /tmp/moodle.tgz https://download.moodle.org/download.php/direct/stable401/moodle-4.1.1.tgz && \
#   tar xfzv /tmp/moodle.tgz --strip-components 1 -C /var/www/html

WORKDIR /var/www/html

COPY docker-entrypoint.sh /usr/local/bin

COPY install_database.sh /usr/local/bin

COPY wait-for-it.sh /usr/local/bin

COPY config.php /config.php

COPY default.conf /etc/nginx/sites-available/default

COPY php.ini /etc/php/7.4/fpm/php.ini

VOLUME ["/var/cache/nginx"]

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 443 80

CMD ["/bin/sh", "-c", "service php7.4-fpm start && nginx -g \"daemon off;\""]
