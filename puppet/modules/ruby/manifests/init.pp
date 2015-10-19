class ruby {
  include stdlib ## needed for 'file_line'

  ## dependencies in ruby
  Package { ensure => "installed" }

  $ruby_deps_list = [
                        'ImageMagick',
                        'libxml2',
                        'g++',
                        'make',
                        'libgmp-dev',
                        'libyaml-dev',
                        'libsqlite3-dev',
                        'sqlite3',
                        'libxml2-dev',
                        'libxslt-dev',
                        'autoconf',
                        'libc6-dev',
                        'ncurses-dev',
                        'automake',
                        'libtool',
                        'bison',
                        'subversion',
                        'pkg-config',
                        'curl',
                        'build-essential',
                        'libcurl4-openssl-dev',
                        'apache2-prefork-dev',
                        'libapr1-dev',
                        'libaprutil1-dev',
                        'libx11-dev',
                        'libffi-dev',
                        'tcl-dev',
                        'tk-dev',
                        'openssl',
                        'libreadline6',
                        'libreadline6-dev',
                        'zlib1g',
                        'zlib1g-dev',
                        'libssl-dev',
            ]
  package { $ruby_deps_list: }->
  ## added locale settings 
  exec { 'append_etc_bash.bashrc':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/ruby/_workaround/append__etc_bash.bashrc  --modulepath=/vagrant/puppet/modules',
  }->
  ## download
  exec { 'get_ruby223_source':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/bin/wget http://ftp.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.gz'",
    cwd     => '/home/vagrant',
    creates => '/home/vagrant/ruby-2.2.3.tar.gz',
  }->
  ## unpack
  exec { 'untar_ruby223':
    command => "/usr/bin/sudo /bin/su vagrant -c '/bin/tar -xzvf /home/vagrant/ruby-2.2.3.tar.gz'",
    cwd     => '/home/vagrant',
    creates => '/home/vagrant/ruby-2.2.3/CONTRIBUTING.md',
  }->
  ## cd; ./configure --disable-install-rdoc
  exec { 'configure_ruby223':
    command => "/usr/bin/sudo /bin/su vagrant -c '/home/vagrant/ruby-2.2.3/configure --disable-install-rdoc'",
    cwd     => '/home/vagrant/ruby-2.2.3',
    creates => '/home/vagrant/ruby-2.2.3/Makefile',
  }->
  ## make
  exec { 'make_ruby223':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/bin/make -f /home/vagrant/ruby-2.2.3/Makefile'",
    cwd     => '/home/vagrant/ruby-2.2.3',
  }->
  ## sudo make install
  exec { 'sudo_make_install':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/bin/sudo /usr/bin/make install'",
    cwd     => '/home/vagrant/ruby-2.2.3',
    creates => '/usr/local/bin/ruby',
  }->

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
  }->

  ## -----------------------------
  ## install rails
  ## -----------------------------
  exec { 'gem_install_rails':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/local/bin/gem install rails -v 4.2.4'",
    timeout => '0',
  }
}
