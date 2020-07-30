#!/usr/bin/env bash
php_currentdir() {
  echo ${PWD/#\/var\/www\/html/HTML};
}
export PS1="\u@php-${PHP_VERSION}:\$(php_currentdir) $ "
alias XdebugOff="unset XDEBUG_CONFIG"
alias XdebugOn="export XDEBUG_CONFIG=\"idekey=ide\""
alias Console="php bin/console"
