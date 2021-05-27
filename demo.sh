#!/bin/bash
export DOCKER_PATH_WEB=$PWD/demo/web
export DOCKER_PATH_VOLUMES=$PWD/demo/volumes
(sleep 10 && python3 -m webbrowser -t https://p1.docker.localhost/phpinfo.php && python3 -m webbrowser -t  https://php7-p1.docker.localhost/phpinfo.php && python3 -m webbrowser -t https://p2.docker.localhost/index.php) &
docker-compose up
