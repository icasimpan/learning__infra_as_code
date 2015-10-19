class discourse {
  ## git is only needed in getting the discourse source code from github
  package { 'git':
    ensure => 'present',
    require => Exec['apt-get update'],
  }->
  ## Get the discourse source code...
  exec { 'gitclone_discourse':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/discourse/_workaround/get_discourse_code.pp  --modulepath=/vagrant/puppet/modules',
    require => Package['git'],
    creates  => '/opt/discourse/COPYRIGHT.txt',
    timeout  => '0',
  }->
  exec { 'ensure_discourse_source_ownerOK':
    command => '/usr/bin/sudo /bin/chown -R vagrant:vagrant /opt/discourse',
    tries   => '5',
  }->

  exec { 'temp_tweak_permission_for_jsondiscourse01':
    command => '/usr/bin/sudo /bin/chmod o+w -R /usr/local/lib/ruby/gems/2.2.0/',
  }->
  exec { 'temp_tweak_permission_for_jsondiscourse02':
    command => '/usr/bin/sudo /bin/chmod o+w /usr/local/bin',
  }->
  exec { 'bundle_install_discourse':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/local/bin/bundle install'",
    cwd     => "/opt/discourse/app",
    tries   => '5',
    timeout => '0',
  }->
  ## db seeding
  exec { 'temp_tweak_permission_for_discourseLog':
    command => '/usr/bin/sudo /bin/chown vagrant:vagrant -R /opt/discourse',
  }->
  exec { 'discourse_dbseeding':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/local/bin/bundle exec rake db:create db:migrate db:test:prepare'",
    cwd     => "/opt/discourse/app",
    tries   => '5',
    timeout => '0',
  }->
  exec {'set_basic_upstart_config':
    command => "/usr/bin/sudo /bin/cp /vagrant/puppet/modules/discourse/files/discourse.conf /etc/init/",
  }->
  exec {'chmod_discourse_upstart_config':
    command => "/usr/bin/sudo /bin/chmod ugo-x /etc/init/discourse.conf",
  }->
  ## make sure discourse upstart is really started
  exec {'upstart_discourse_start':
    command => "/usr/bin/sudo /sbin/start discourse",
  }->
  ### now, do some permission clean-ups
  exec { 'permission_close_01':
     command => '/usr/bin/sudo /bin/chmod o-w -R /usr/local/lib/ruby/gems/2.2.0/',
  }->
  exec { 'permission_close_02':
     command => '/usr/bin/sudo /bin/chmod o-w /usr/local/bin',
  }
}
