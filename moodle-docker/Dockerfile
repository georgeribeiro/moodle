FROM debian:buster-slim
 
ENV NGINX_ROOT=/var/www/html \
  MOODLE_LIB_DIR=/var/lib/moodle \
  WWWROOT=localhost \
  DATAROOT=/var/lib/html/moodledata \
  DB_TYPE=mysqli \
  ADMIN_USER=admin \
  FULLNAME=moodle \
  SHORTNAME=moodle

RUN set -ex && \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y curl nginx sendmail php7.3-cli  php7.3-fpm  php7.3-iconv  php7.3-mbstring  php7.3-curl  \
    php7.3-tokenizer  php7.3-xmlrpc php7.3-soap php7.3-ctype php7.3-zip php7.3-gd php7.3-simplexml php7.3-dom  \
    php7.3-xml php7.3-intl  php7.3-json php7.3-mysql  sudo && \
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log && \
  rm /etc/nginx/sites-available/default && \
  echo 'security.limit_extensions = .php' >> '/etc/php/7.3/fpm/pool.d/www.conf' && \
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
    } | tee /etc/php/7.3/fpm/pool.d/zzz-php.conf && \
  mkdir -p ${MOODLE_LIB_DIR} && \
  mkdir -p ${DATAROOT} && \
  chown -R www-data:www-data ${NGINX_ROOT} && \
  chown -R www-data:www-data ${DATAROOT} && \
  chmod -R 755 ${NGINX_ROOT} && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY default /etc/nginx/sites-available

COPY docker-entrypoint.sh /usr/local/bin

COPY install_database.sh /usr/local/bin

COPY wait-for-it.sh /usr/local/bin

COPY config.php /config.php

VOLUME ["/var/cache/nginx"]

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 443 80

CMD ["/bin/sh", "-c", "service php7.3-fpm start && nginx -g \"daemon off;\""]
