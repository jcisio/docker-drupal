ARG PHP_VERSION
FROM wodby/drupal-php:$PHP_VERSION
USER root
RUN set -xe; \
    apk add poppler-utils pv 'npm<16'; \
    wget -qO- https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer2; \
    mkdir /etc/drupal; \
    echo "source /etc/drupal/php.bashrc" >> /home/wodby/.bashrc

COPY php.bashrc /etc/drupal/php.bashrc
COPY drupal-settings.php /etc/drupal/settings.php
