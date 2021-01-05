<?php

/**
 * Auto configuration for Drupal.
 *
 * Just put two lines in your settings.php:
 *
 *     # You can either use this shortcut:
 *     $db_name = 'myproject';
 *     # Or the long format:
 *     # $databases['default']['default']['database'] = 'myproject';
 *     # Then include the provided settings file. Path can not be changed.
 *     require '/etc/drupal/settings.php';
 *
 * Then it will fill all the connection details. It will also create the
 * database if not exists yet. Please note that the root credentials are used,
 * thus please make sure that it is only your local development instance.
 */

if (isset($db_name)) {
  $databases['default']['default']['database'] = $db_name;
  unset($db_name);
}

if (isset($databases['default']['default']['database']) && !isset($databases['default']['default']['host'])) {
  $_db = [
    'host' => 'mariadb',
    'driver' => 'mysql',
    'username' => 'root',
    'password' => 'password',
  ];
  $name = $databases['default']['default']['database'];
  $conn = new PDO("{$_db['driver']}:host={$_db['host']}", $_db['username'], $_db['password']);
  if ($conn->prepare('CREATE SCHEMA IF NOT EXISTS ' . $name)->execute()) {
    $databases['default']['default'] += $_db;
  }
}
// Drupal 8.
$settings['trusted_host_patterns'][] = '\.docker\.localhost$';
$settings['reverse_proxy'] = TRUE;
$settings['reverse_proxy_addresses'] = [$_SERVER['REMOTE_ADDR']];

// Traefik forwards traffic from https to Apache http
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
  $_SERVER['HTTPS'] = 'on';
}

