ARG PHP_VERSION
ARG WODBY_VERSION
FROM wodby/drupal-php:$PHP_VERSION-dev-$WODBY_VERSION
RUN set -xe; \
    sudo apk add poppler-utils pv; \
    wget -qO- https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer2; \
    sudo mkdir /etc/drupal; \
    echo "source /etc/drupal/php.bashrc" >> /home/wodby/.bashrc

COPY php.bashrc /etc/drupal/php.bashrc
COPY drupal-settings.php /etc/drupal/settings.php
