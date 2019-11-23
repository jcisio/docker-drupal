#!/usr/bin/env bash

DockerGo() {
  docker_dest="/var/www"
  if [[ "$@" != "" ]]; then
    args=$@
  else
    args=bash
  fi
  # @todo detect PHP version.
  docker exec -it drupal_php71 bash -c "cd ${PWD/#$DOCKER_PATH_WEB/$docker_dest}; exec $args"
}
