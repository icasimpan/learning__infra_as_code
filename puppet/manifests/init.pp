exec { 'apt-get update':
  path => '/usr/bin',
}

package { 'vim':
  ensure => present,
}

file { '/var/www':
  ensure => 'directory',
}

include nginx
include redis
include postgres
include other_deps
include rbenv
