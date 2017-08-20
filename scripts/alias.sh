# Execute a command in the corresponding directory.
if [[ -n "${BASH_SOURCE[0]}" ]]; then
  CURRENTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
else
  CURRENTDIR="$(dirname "$(which "$0")")"
fi
CURRENTDIR="$(dirname "$CURRENTDIR")"
export DOCKER_PATH_SOURCE="$CURRENTDIR"

DockerGo() {
  source $DOCKER_PATH_SOURCE/.env
  docker_dest="/var/www"
  if [[ "$@" != "" ]]; then
    args=$@
  else
    args=bash
  fi
  docker exec -it dockerdrupal_php_1 bash -c "cd ${PWD/#$DOCKER_PATH_WEB/$docker_dest}; exec $args"
}
