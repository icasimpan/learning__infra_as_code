## NOTE: Must be run using the command:
##       /usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/postgres/_workaround/pghba_copy.pp
##
file { '/etc/postgresql/9.3/main/pg_hba.conf':
  ensure => present,
  source => '/vagrant/puppet/modules/postgres/files/pg_hba.conf', 
  owner => postgres,
}
