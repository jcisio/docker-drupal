#!/usr/bin/env bash

DockerGo() {
  docker_dest="/var/www"
  if [[ "$@" != "" ]]; then
    args=$@
  else
    args=bash
  fi
  # @todo detect PHP version.
  RELATIVE_PATH=${PWD/#$DOCKER_PATH_WEB\/html\//}
  VHOST_FILE="$DOCKER_PATH_WEB/conf/apache/vhosts.conf"
  PHP_VERSION=$(grep $RELATIVE_PATH $VHOST_FILE | awk '{print $NF}')
  if [[ $PHP_VERSION =~ ^[57].[0-9]$ ]]; then
    CONTAINER=php${PHP_VERSION/./}
  else
    CONTAINER=php73
  fi
  docker exec -it -e SSH_AUTH_SOCK=/ssh-agent drupal_$CONTAINER bash -c "cd ${PWD/#$DOCKER_PATH_WEB/$docker_dest}; exec $args"
}
