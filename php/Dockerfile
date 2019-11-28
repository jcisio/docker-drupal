ARG PHP_VERSION
ARG WODBY_VERSION
FROM wodby/drupal-php:$PHP_VERSION-dev-$WODBY_VERSION
COPY php.bashrc /etc/php.bashrc
RUN echo "source /etc/php.bashrc" >> /home/wodby/.bashrc

