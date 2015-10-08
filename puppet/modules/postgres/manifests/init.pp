class postgres {
  include postgres::install, postgres::config, postgres::service
}

class postgres::install {
  package { 'postgresql':
    ensure => present
  }  
}

class postgres::config {
  ## replace pg_hba.conf with needed createdb permission for 'vagrant'
  ## NOTE: Using workaround
  exec { 'role_vagrant':
    command => '/vagrant/workarounds/postgre_pghba',
  }

  ##
  ## Add 'createdb' permission for 'vagrant'
  ##   --> sudo -u postgres createuser vagrant --createdb
  ## NOTE: Using workaround
  exec { 'sudo_createuser':
    command => '/vagrant/workarounds/postgre_createdb',
  }
}

class postgres::service {
  service { 'postgresql':
    ensure => running,
    enable => true, 
  }
}


Class["postgres::install"] -> Class["postgres::config"] -> Class["postgres::service"]
