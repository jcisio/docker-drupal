<?php

/**
 * Auto configuration for Drupal.
 *
 * Just put a single line in your settings.php:
 *
 *     $databases['default']['default']['database'] = 'myproject';
 *     require '/etc/drupal-settings.php';
 *
 * Then it will fill all the connection details. It will also create the database if not exists yet.
 */
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
