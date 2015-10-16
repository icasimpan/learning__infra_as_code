  ## download
  exec { 'get_ruby223_source':
    command => '/usr/bin/wget http://ftp.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz',
    cwd     => '/home/vagrant',
    creates => '/home/vagrant/ruby-2.2.3.tar.gz',
  }->
  ## unpack 
  exec { 'untar_ruby223':
    command => '/bin/tar -xzvf /home/vagrant/ruby-2.2.3.tar.gz',
    cwd     => '/home/vagrant',
    creates => '/home/vagrant/ruby-2.2.3/CONTRIBUTING.md',
  }->
  ## cd; ./configure --disable-install-rdoc
  exec { 'configure_ruby223':
    command => '/home/vagrant/ruby-2.2.3/configure --disable-install-rdoc',
    cwd     => '/home/vagrant/ruby-2.2.3',
    creates => '/home/vagrant/ruby-2.2.3/Makefile',
  }->
  ## make
  exec { 'make_ruby223':
    command => '/usr/bin/make -f /home/vagrant/ruby-2.2.3/Makefile',
    cwd     => '/home/vagrant/ruby-2.2.3',
  }->
  ## sudo make install
  exec { 'sudo_make_install':
    command => '/usr/bin/sudo /usr/bin/make install',
    cwd     => '/home/vagrant/ruby-2.2.3',
    creates => '/usr/local/bin/ruby',
  }

  ## -----------------------------
  ## install 'gem install bundler'
  ## -----------------------------
  exec { 'temp_tweak_permission_for_gem01':
    command => '/usr/bin/sudo /bin/chmod o+w -R /usr/local/lib/ruby/gems/2.2.0/', 
  }->
  exec { 'temp_tweak_permission_for_gem02':
    command => '/usr/bin/sudo /bin/chmod o+w /usr/local/bin',
  }->
  exec { 'gem_install_bundler':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/local/bin/gem install bundler'",
  }
