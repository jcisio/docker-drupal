#!/bin/bash
export DOCKER_PATH_WEB=$PWD/demo/web
export DOCKER_PATH_MYSQL=$PWD/demo/mysql
(sleep 5 && python3 -m webbrowser -t http://p1.docker.localhost/phpinfo.php && python3 -m webbrowser -t  http://php7-p1.docker.localhost/phpinfo.php && python3 -m webbrowser -t http://p2.docker.localhost/index.php) &
docker-compose up
