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
`*.project1.docker.localhost` using PHP 5.6 with `~/web/html/project1/www` as
docroot, `project2.docker.localhost` and `*.project2.docker.localhost` using PHP 7.1 with
`~/web/html/project2/www` as docroot.

Check the `demo` folder and the `demo.sh` script for an example.

Running the container
---------------------

You need to [install Docker and Docker Compose](https://docs.docker.com/compose/install/) first.

Then, to start all containers:

    docker-compose up

The above command starts all containers. To stop, press `Ctrl-C`. To remove
containers, use:

    docker-compose down

To open an interactive Bash shell in a container:

    docker exec -it <container id> bash

You can also run arbitrary command using that same syntax:

    docker exec drupal_php71 php -v

Services
--------

The docker-compose file provides the following services:

* `apache`: Apache instance with multiple virtual hosts support. The hosts are
  accessible via `http://any.sub.domain.docker.localhost`.
* `phpXY`: PHP instances with any PHP version X.Y from 5.6 to 7.3.
* `mysql`: MariaDB (a variant of MySQL) server 10.3.
* `pma`: PHPMyAdmin, accessible via `http://pma.docker.localhost`.
* `mailhog`: mailhog (mailcatcher alternative in Go), accessible via port 1025
from other services, web interface accessible via
`http://mailhog.docker.localhost.`
* `traefik`: træfik reverse proxy, web interface accessible via
`http://docker.localhost:8080`.
* `portainer`: Docker container manager, accessible via
`http://portainer.docker.localhost`. From there you can read logs, open a console, check stats or inspect a container.
* `xhprof`: Web viewer for xhprof, accessible via `http://xhprof.docker.localhost/`

## Xdebug

Xdebug is installed and enabled. However it is not auto started. To enable it in
a browser, simply set the XDEBUG_SESSION cookie, and remove this cookie to
disable it. Similarly, in CLI mode (inside a PHP container), set the
XDEBUG_CONFIG variable (e.g. `export XDEBUG_CONFIG="idekey=ide"`) to enabled and
remove that variable to disable Xdebug. There are two aliases `XdebugOn` and
`XdebugOff` to help you to turn on/off Xdebug in CLI.

In the first request, your IDE will ask for path mapping and save it for later
requests.

## Xhprof

If you use the latest version of [XHProf contrib module](https://www.drupal.org/project/xhprof), then you don't have to do anything. XHProf by Tideways is enabled in PHP by default, and the module is already shipped with a viewer.

If you don't, then see https://wodby.com/docs/stacks/php/containers/#xhprof for information. You can use use the following snippet for manual profiling:

```PHP
if (extension_loaded('tideways_xhprof')) {
  tideways_xhprof_enable(TIDEWAYS_XHPROF_FLAGS_MEMORY | TIDEWAYS_XHPROF_FLAGS_CPU);
}

// Code which should be profiled.
// ...

// Store profile.
if (extension_loaded('tideways_xhprof')) {
  $xhprof_out = '/mnt/files/private/xhprof';
  if (!file_exists($xhprof_out)) {
    mkdir($xhprof_out);
  }

  file_put_contents(sprintf('%s/%s.%s.xhprof', $xhprof_out, uniqid(), 'web'), serialize(tideways_xhprof_disable()));
}
```

The XHProf viewer is available at `http://xhprof.docker.localhost`

More services
-------------

* There is some scripts in the `scripts` directory. Put something like
`source ~/projects/docker-drupal/scripts/alias.sh` in your `.bashrc` file and
you can use the alias `DockerGo` to execute any command (like `drush`) in the
corresponding directory inside the PHP container. However we are working to
make pipeline (e.g. `cat dump.sql | DockerGo drush sqlc`) works. Another alias
is `DockerExec` that allows to quickly connect to a container.
