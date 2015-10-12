class ruby {
  ## added locale settings 
  exec { 'append_etc_bash.bashrc':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/ruby/_workaround/append__etc_bash.bashrc  --modulepath=/vagrant/puppet/modules',
  }

  ## dependencies in ruby
  Package { ensure => "installed" }

  $ruby_deps_list = [
                        'ImageMagick',
                        'libxml2',
                        'g++',
                        'make',
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
                        'git',
            ]
  package { $ruby_deps_list: }

  ## run rvm-installer
  exec { 'rvm_installer_run':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/ruby/_workaround/rvm_install.pp',
  }

  ## create 'rvm' group ...
  ## and make 'vagrant' part of 'rvm' group
  group { 'rvm':
    ensure => 'present',
  }->
  user { 'vagrant':
    ensure => 'present',
    groups => 'rvm',
  }

  exec { 'rvm_install__libyaml':
    environment => ['HOME=/home/vagrant'],
    command => '/home/vagrant/.rvm/bin/rvm pkg install libyaml',
    require => Exec['rvm_installer_run'],
  }

  exec { 'rvm_reinstall_all':
    environment => ['HOME=/home/vagrant'],
    command => '/home/vagrant/.rvm/bin/rvm reinstall all --force',
    require => Exec['rvm_installer_run'],
  }

  exec { 'rvm_install_turbo':
    environment => ['HOME=/home/vagrant'],
    command => '/home/vagrant/.rvm/bin/rvm install 2.0.0-turbo',
    require => Exec['rvm_installer_run'],
  }

  exec { 'rvm_use_turbo':
    environment => ['HOME=/home/vagrant'],
    command => '/home/vagrant/.rvm/bin/rvm use 2.0.0-turbo --default',
    require => Exec['rvm_installer_run'],
  }

  include stdlib

  file { '/home/vagrant/.gemrc':
    ensure => 'present',
  }->
  file_line { 'no_docu_home_gemrc':
    path => '/home/vagrant/.gemrc',
    line => 'gem: --no-document',
    match => '^gem:\ --no-document$',
  }

  ## run rvm-installer
  exec { 'global_gemrc_writer':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/ruby/_workaround/global_gemrc.pp --modulepath=/vagrant/puppet/modules/',
  }

}
