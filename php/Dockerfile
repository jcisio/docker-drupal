ARG PHP_VERSION
ARG WODBY_VERSION
ARG DBPASSWORD
ARG DB_HOST
FROM wodby/drupal-php:$PHP_VERSION-dev-$WODBY_VERSION
RUN sudo apk add poppler-utils
RUN sudo mkdir /etc/drupal
COPY php.bashrc /etc/drupal/php.bashrc
COPY drupal-settings.php /etc/drupal/settings.php
RUN echo "source /etc/drupal/php.bashrc" >> /home/wodby/.bashrc
RUN echo $"[client]\n\
user=root\n\
password=$DBPASSWORD\n\
host=$DB_HOST" > /home/wodby/.my.cnf
RUN sudo update-ca-certificates
