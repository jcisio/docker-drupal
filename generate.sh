#!/bin/bash
if [ -d tests ]; then
  echo 'Please remove `.env` file and `data` folder to generate example structure.'
  exit 1
fi
mkdir -p tests/{mysql,web/{conf/apache,html/{w1,w2}}}
echo '<?php phpinfo();' > tests/web/html/w1/phpinfo.php
echo '<?php phpinfo();' > tests/web/html/w2/phpinfo.php
echo 'Use vhost test1 w1 5.6
Use vhost php7-test1 w1 7.1
Use vhost test2 w2 7.1' > tests/web/conf/apache/vhosts.conf
echo "DOCKER_PATH_WEB=$PWD/tests/web
DOCKER_PATH_MYSQL=$PWD/tests/mysql
WODBY_VERSION=4.13.13
MARIADB_TAG=10.4-3.6.4" > tests/.env
cd tests
(sleep 5 && python3 -m webbrowser -t http://test1.docker.localhost/phpinfo.php &&  python3 -m webbrowser -t  http://php7-test1.docker.localhost/phpinfo.php && python3 -m webbrowser -t  http://test2.docker.localhost/phpinfo.php) &
docker-compose -f ../docker-compose.yml up
cd ..
rm -rf tests
