# docker-drupal
Easy Drupal development with multiple vhosts using Docker

Configuration
-------------

Copy `.env-example` to `.env` and edit the path to PHP code base and MySQL data.

You need code base (let's say `~/workspace`) for your vhost with the
following files :

* `www` folder contain different projects

* `conf/apache/vhosts.conf` which each line defining a vhost:

      Use vhost project1/www project1 5.6
      Use vhost project2/www project2 7.1

The above config sets up two virtual hosts: `project1.example.com` and
`*.project1.example.com` using PHP 5.6 with `~/workspace/www/project1/www` as
docroot, `project2.example.com` and `*.project2.example.com` using PHP 7.1 with
`~/workspace/www/project2/www` as docroot.

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

More services
-------------

* There is some scripts in the `scripts` directory. Put something like
`source ~/projects/docker-drupal/scripts/alias.sh` in your `.bashrc` file and
you can use the alias `DockerGo` to execute any command (like `drush`) in the
corresponding directory inside the PHP container. However we are working to
make pipeline (e.g. `cat dump.sql | DockerGo drush sqlc`) works.

* Run nodejs in the current directory:

    docker run -v "$PWD":/usr/src/app -w /usr/src/app node:4 npm install
