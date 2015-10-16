  exec { 'gem_install_rails':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/local/bin/gem install rails -v 4.2.4'",
    timeout => '0',
  }

