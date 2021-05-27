<h1>Project 2</h1>

<ul>
  <li><a href="http://adminer.docker.localhost/">Adminer</a></li>
  <li><a href="http://pma.docker.localhost/">PhpMyAdmin</a></li>
  <li><a href="http://mailhog.docker.localhost/">mailhog</a></li>
  <li><a href="http://xhprof.docker.localhost/">Xhprof viewer</a> (there are traces of this page)</li>
  <li><a href="http://portainer.docker.localhost/">Portainer</a></li>
  <li><a href="http://docker.localhost:8080/">Traefik</a></li>
</ul>

<?php

// Start profiling.
if (extension_loaded('tideways_xhprof')) {
  tideways_xhprof_enable(TIDEWAYS_XHPROF_FLAGS_MEMORY | TIDEWAYS_XHPROF_FLAGS_CPU);
}

phpinfo();

for ($i = 0; $i < 100000; $i++) {
  $temp = random_int(0, 999999);
}

// Store profile.
if (extension_loaded('tideways_xhprof')) {
  $xhprof_out = '/mnt/files/private/xhprof';
  file_exists($xhprof_out) || mkdir($xhprof_out);
  file_put_contents(sprintf('%s/%s.%s.xhprof', $xhprof_out, uniqid(), 'web'), serialize(tideways_xhprof_disable()));
}
