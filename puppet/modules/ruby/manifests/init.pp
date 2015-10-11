class ruby {
  exec { 'append_etc_bash.bashrc':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/ruby/_workaround/append__etc_bash.bashrc  --modulepath=/vagrant/puppet/modules',
  }
}
