ARG PHP_VERSION
ARG WODBY_VERSION
FROM wodby/drupal-php:$PHP_VERSION-dev-$WODBY_VERSION
RUN echo -e "\
alias XdebugOff=\"unset XDEBUG_CONFIG\"\n\
alias XdebugOn=\"export XDEBUG_CONFIG=\\\"idekey=ide\\\"\""\
 >> /home/wodby/.bashrc

