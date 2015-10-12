class discourse {

  ## Get the discourse source code...
  exec { 'gitclone_discourse':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/discourse/_workaround/get_discourse_code.pp  --modulepath=/vagrant/puppet/modules',
  }
  
  ##
  ## TODO:
  ##   1. Make sure the discourse app runs and is accessible from 
  ##      eth1 ip @port 80
  ##
  ##    * cd /opt/discourse/ap
  ##    * bundle install
  ##    * bundle exec rake db:create db:migrate db:test:prepare
  ##
  ##   2. Only above is running, deamonize
  ##

}
