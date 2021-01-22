ARG PHP_VERSION
ARG WODBY_VERSION
FROM wodby/drupal-php:$PHP_VERSION-dev-$WODBY_VERSION
RUN sudo apk add poppler-utils pv
RUN sudo mkdir /etc/drupal
COPY php.bashrc /etc/drupal/php.bashrc
COPY drupal-settings.php /etc/drupal/settings.php
RUN echo "source /etc/drupal/php.bashrc" >> /home/wodby/.bashrc
