ARG PHP_VERSION
ARG WODBY_VERSION
ARG DBPASSWORD
ARG DB_HOST
FROM wodby/drupal-php:$PHP_VERSION-dev-$WODBY_VERSION
RUN sudo mkdir /etc/drupal
COPY php.bashrc /etc/drupal/php.bashrc
COPY drupal-settings.php /etc/drupal/settings.php
RUN echo "source /etc/drupal/php.bashrc" >> /home/wodby/.bashrc
RUN echo "[client]
user=root
password=$DBPASSWORD
host=$DB_HOST" > /home/wodby/.my.cnf
