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
    cwd     => "/opt/discourse",
    tries   => '5',
    timeout => '0',
  }

  ## gem install bundle --install-dir /home/vagrant/.rvm/gems/ruby-2.2.3
  #exec { 'install_gem_bundle':
  #  command  => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/discourse/_workaround/final_steps.pp',
  #  creates  => '/home/vagrant/.rvm/gems/ruby-2.2.3/bin/bundle',
  #  tries    => '5',
  #}
  
  ##
  ## TODO:
  ##   1. Make sure the discourse app runs and is accessible from 
  ##      eth1 ip @port 80
  ##
  ##    * cd /opt/discourse/app
  ##    * bundle install
  ##    * bundle exec rake db:create db:migrate db:test:prepare
  ##
  ##   2. Once above is running, deamonize
  ##

}
