# docker-drupal
Easy Drupal development with multiple vhosts using Docker.

Quick test
----------

To test quickly, run `./demo.sh`, it will run `docker-compose` with the `demo` folder and open example urls in browser. When finish testing, press Ctrl-C to clean up containers.

Configuration
-------------

Export the path to PHP code base and MySQL data into environment variables. You can put them in ~/.profile so that they won't be lost after reboot.

    export DOCKER_PATH_WEB=/home/drupal/web
    export DOCKER_PATH_MYSQL=/home/drupal/mysql

You need code base (let's say `~/web`) for your vhost with the following files:

* `html` folder contain different projects. All your files should be here.

* `cache` folder for persistent cache storage like Bash history or Drush cache.

* `conf/apache/vhosts.conf` which each line defining a vhost:

      Use vhost project1 project1/www 5.6
      Use vhost project2 project2/www 7.1

The above config sets up two virtual hosts: `project1.docker.localhost` and
`*.project1.docker.localhost` using PHP 5.6 with `~/workspace/www/project1/www` as
docroot, `project2.docker.localhost` and `*.project2.docker.localhost` using PHP 7.1 with
`~/workspace/www/project2/www` as docroot.

Check the `demo` folder and the `demo.sh` script for an example.

Running the container
---------------------

You need to [install Docker and Docker Compose](https://docs.docker.com/compose/install/) first.

Then, to start all containers:

    docker-compose up

The above command starts all containers. To stop, press `Ctrl-C`. To remove
containers, use:

    docker-compose down

To ssh into a container:

    docker exec -it <container id> bash

You can also run arbitrary command using that same syntax:

    docker exec dockerdrupal_php_1 php-5.3 -v

Services
--------

The docker-compose file provides the following services:

* `php`: a phpfarm instance with multiple virtual hosts and https support. A wide
range of PHP versions (from 5.3 to 7.1) is supported. The hosts are accessible
via `http[s]://projectname.docker.localhost`. You will need to accept the TLS
certificate once.
* `mysql`: MySQL server 5.7, accessible from other services.
* `pma`: PHPMyAdmin, accessible via `http://pma.docker.localhost`.
* `mailhog`: mailhog (mailcatcher alternative in Go), accessible via port 1025
from other services, web interface accessible via
`http://mailhog.docker.localhost.`
* `traefik`: træfik reverse proxy, web interface accessible via
`http://docker.localhost:8080`.
* `portainer`: Docker container manager, accessible via
`http://portainer.docker.localhost`.

## Xdebug

Xdebug is installed and enabled. However it is not auto started. To enable it in
a browser, simply set the XDEBUG_SESSION cookie, and remove this cookie to
disable it. Similarly, in CLI mode (inside a PHP container), set the
XDEBUG_CONFIG variable (e.g. `export XDEBUG_CONFIG="idekey=ide"`) to enabled and
remove that variable to disable Xdebug.

In the first request, your IDE will ask for path mapping and save it for later
requests, based on the hostname (e.g. `p2.docker.localhost`). When debugging in
CLI mode, you need to specify the hostname so that your IDE know to use the
mapping in which project. To set the hostname in CLI:

```
export PHP_IDE_CONFIG="serverName=p2.docker.localhost"
```

I have to admit that there should be an easier way to setup the mapping
automatically for all projects, but have not found it.

More services
-------------

* There is some scripts in the `scripts` directory. Put something like
`source ~/projects/docker-drupal/scripts/alias.sh` in your `.bashrc` file and
you can use the alias `DockerGo` to execute any command (like `drush`) in the
corresponding directory inside the PHP container. However we are working to
make pipeline (e.g. `cat dump.sql | DockerGo drush sqlc`) works.

* Run nodejs in the current directory:

    docker run -v "$PWD":/usr/src/app -w /usr/src/app node:4 npm install
