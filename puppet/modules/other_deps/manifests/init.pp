class other_deps {
  include other_deps::install, other_deps::config, other_deps::service
}

class other_deps::install {
  
  ### Install the other dependencies
  package { 'ImageMagick':
    ensure => present,
  }  
  package { 'libxml2':
    ensure => present,
  }  
  package { 'libpq-dev':
    ensure => present,
  }  
  package { 'g++':
    ensure => present,
  }  
  package { 'make':
    ensure => present,
  }  
}

class other_deps::config {
}

class other_deps::service {

}

Class["other_deps::install"] -> Class["other_deps::config"] -> Class["other_deps::service"]
