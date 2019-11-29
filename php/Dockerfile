ARG PHP_VERSION
ARG WODBY_VERSION
FROM wodby/drupal-php:$PHP_VERSION-dev-$WODBY_VERSION
COPY php.bashrc /etc/php.bashrc
COPY drupal-settings.php /etc/drupal-settings.php
RUN echo "source /etc/php.bashrc" >> /home/wodby/.bashrc

