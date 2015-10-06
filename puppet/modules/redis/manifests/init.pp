class redis {
  # Install the redis-server package. This relies on apt-get update
  package { 'redis-server':
    ensure => 'present',
    require => Exec['apt-get update'],
  }

  # Make sure that the redis-server service is running
  service { 'redis-server':
    ensure => running,
    require => Package['redis-server'],
  }
}
