  ## git is only needed in getting the discourse source code from github
  package { 'git':
    ensure => 'present',
  #  require => Exec['apt-get update'],
  }

  ## Get the discourse source code...
  exec { 'gitclone_discourse':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/discourse/_workaround/get_discourse_code.pp  --modulepath=/vagrant/puppet/modules',
    require => Package['git'],
    creates  => '/opt/discourse/COPYRIGHT.txt',
    timeout  => '0',
  }->
  exec { 'ensure_discourse_source_ownerOK':
    command => '/bin/chown -R vagrant:vagrant /opt/discourse',
    tries   => '5',
  }

