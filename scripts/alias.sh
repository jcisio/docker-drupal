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
  if [[ $PHP_VERSION = "5.6" ]]; then
    CONTAINER=php56
  elif [[ $PHP_VERSION = "7.2" ]]; then
    CONTAINER=php72
  elif [[ $PHP_VERSION = "7.3" ]]; then
    CONTAINER=php73
  else
    CONTAINER=php71
  fi
  docker exec -it -e SSH_AUTH_SOCK=/ssh-agent drupal_$CONTAINER bash -c "cd ${PWD/#$DOCKER_PATH_WEB/$docker_dest}; exec $args"
}
