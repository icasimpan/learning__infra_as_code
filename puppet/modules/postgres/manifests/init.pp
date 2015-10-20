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
  exec { 'role_vagrant':
    command => "/usr/bin/sudo /bin/su postgres -c '/bin/cp /vagrant/puppet/modules/postgres/files/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf'",
  }

  ##
  ## Add 'createdb' permission for 'vagrant'
  ##   --> sudo -u postgres createuser vagrant -s
  exec { 'sudo_createuser':
    command => "/usr/bin/sudo /bin/su postgres -c '/usr/bin/createuser vagrant -s'",
  }

  ## 
  ## Prepare postgres for discourse installation later..
  ## 
  exec { 'prepare_pgsql_discourse01':
    command => "/usr/bin/sudo /bin/su postgres -c '/usr/bin/psql -c \"ALTER USER vagrant WITH PASSWORD 'password';\"'",
  } ->
  exec { 'prepare_pgsql_discourse02':
    command => "/usr/bin/sudo /bin/su postgres -c '/usr/bin/psql -c \"create database discourse_development owner vagrant encoding 'UTF8' TEMPLATE template0;\"'",
  } ->
  exec { 'prepare_pgsql_discourse03':
    command => "/usr/bin/sudo /bin/su postgres -c '/usr/bin/psql -c \"create database discourse_test owner vagrant encoding 'UTF8' TEMPLATE template0;\"'",
  } ->
  exec { 'prepare_pgsql_discourse04':
    command => "/usr/bin/sudo /bin/su postgres -c '/usr/bin/psql -d discourse_development -c \"CREATE EXTENSION hstore;\"'",
  } ->
  exec { 'prepare_pgsql_discourse05':
    command => "/usr/bin/sudo /bin/su postgres -c '/usr/bin/psql -d discourse_development -c \"CREATE EXTENSION pg_trgm;\"'",
  }
}

class postgres::service {
  service { 'postgresql':
    ensure => running,
    enable => true, 
  }
}


Class["postgres::install"] -> Class["postgres::config"] -> Class["postgres::service"]
