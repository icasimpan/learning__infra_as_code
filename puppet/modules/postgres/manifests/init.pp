class postgres {
  include postgres::install, postgres::config, postgres::service
}

class postgres::install {
  Package { ensure => "installed" }
  $pg_deps_list = [
                    'postgresql',
                    'libpq-dev',
                    'postgresql-contrib-9.3',
                    'postgresql-server-dev-9.3',
                  ]
  package { $pg_deps_list: }
}

class postgres::config {
  ## replace pg_hba.conf with needed createdb permission for 'vagrant'
  ## NOTE: Using workaround
  exec { 'role_vagrant':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/postgres/_workaround/pghba_copy.pp',
  }

  ##
  ## Add 'createdb' permission for 'vagrant'
  ##   --> sudo -u postgres createuser vagrant -s
  ## NOTE: Using workaround
  exec { 'sudo_createuser':
    #command => '/vagrant/puppet/_workarounds/postgres_createdb.sh',
	command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/postgres/_workaround/createdb_superuser_vagrant.pp',
  }
}

class postgres::service {
  service { 'postgresql':
    ensure => running,
    enable => true, 
  }
}


Class["postgres::install"] -> Class["postgres::config"] -> Class["postgres::service"]
