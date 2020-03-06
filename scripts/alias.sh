#!/usr/bin/env bash

_DockerContainerPath() {
  echo -n ${PWD/#$DOCKER_PATH_WEB\/html\//}
}

# This function find the corresponding PHP container and log into it.
# The PHP version is detected using the vhost.conf file. However, please note
# that it is pointed to docroot in the vhost configuration, so you must be
# inside docroot to be detected correctly.
DockerGo() {
  docker_dest="/var/www"
  if [[ "$@" != "" ]]; then
    args=$@
  else
    args=bash
  fi
  RELATIVE_PATH=`_DockerContainerPath`
  VHOST_FILE="$DOCKER_PATH_WEB/conf/apache/vhosts.conf"
  cat $VHOST_FILE | while read p; do
    DOCROOT=$(echo $p | cut -f4 -d' ')
    if [[ $RELATIVE_PATH == $DOCROOT* ]]; then
      PHP_VERSION=$(echo $p | cut -f5 -d' ')
    fi
  done
  if [[ $PHP_VERSION =~ ^[57].[0-9]$ ]]; then
    CONTAINER=php${PHP_VERSION/./}
  else
    CONTAINER=php73
  fi
  docker exec -it -e SSH_AUTH_SOCK=/ssh-agent drupal_$CONTAINER bash -c "cd ${PWD/#$DOCKER_PATH_WEB/$docker_dest}; exec $args"
}

DockerExec() {
  if [[ "$1" == "" ]]; then
    echo "Please specify a container name e.g. 'node' or 'ruby'."
    return 1
  fi

  workingpath="/"
  webcontainers=(apache node ruby)
  for value in "${webcontainers[@]}"; do
    [[ "$1" = "$value" ]] && workingpath="/var/www/html/`_DockerContainerPath`"
  done

  docker exec -it -u root -w "$workingpath" drupal_"$1" bash
}
