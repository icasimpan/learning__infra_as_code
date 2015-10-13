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
            ]
  package { $ruby_deps_list: }

  ## added locale settings 
  exec { 'append_etc_bash.bashrc':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/ruby/_workaround/append__etc_bash.bashrc  --modulepath=/vagrant/puppet/modules',
  }

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
  }->
  exec { 'ensure_rvmdir_correct_ownership00':
    command => '/bin/chown -R vagrant:rvm /home/vagrant/.rvm',
  }

  exec { 'rvm_reinstall_all':
    environment => ['HOME=/home/vagrant'],
    command => '/home/vagrant/.rvm/bin/rvm reinstall all --force',
    require => Exec['rvm_installer_run'],
  }->
  exec { 'ensure_rvmdir_correct_ownership01':
    command => '/bin/chown -R vagrant:rvm /home/vagrant/.rvm',
  }

  exec { 'rvm_install_223':
    environment => ['HOME=/home/vagrant'],
    command => '/home/vagrant/.rvm/bin/rvm install 2.2.3',
    require => Exec['rvm_installer_run'],
    timeout => '0',
  }->
  exec { 'ensure_rvmdir_correct_ownership02':
    command => '/bin/chown -R vagrant:rvm /home/vagrant/.rvm',
  }

  exec { 'rvm_use_223':
    environment => ['HOME=/home/vagrant'],
    command => 'rvm use 2.2.3 --default',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin', '/home/vagrant/.rvm/bin', '/home/vagrant/.rvm/bin'],
    require => Exec['rvm_installer_run'],
  }->
  exec { 'ensure_rvmdir_correct_ownership03':
    command => '/bin/chown -R vagrant:rvm /home/vagrant/.rvm',
  }-> 
  file { '/home/vagrant/.bash_profile':
    ensure => 'present',
  }->
  file_line { 'write_rvm_default_homebashrc':
    path  => '/home/vagrant/.bash_profile',
    line  => 'rvm use 2.2.3 --default',
    match => '^rvm\ use\ 2\.2\.3*',
  }

  file { '/home/vagrant/.gemrc':
    ensure => 'present',
  }->
  file_line { 'no_docu_home_gemrc':
    path => '/home/vagrant/.gemrc',
    line => 'gem: --no-ri --no-rdoc',
    match => '^gem:\ --no-ri\ --no-rdoc$',
  }->
  exec { 'change_owner_homegemrc':
    command => '/bin/chown -R vagrant:rvm /home/vagrant/.gemrc',
    require => Group['rvm'],
  }->
  exec { 'install_bundler':
    command => 'gem install bundler',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin', '/home/vagrant/.rvm/bin', '/home/vagrant/.rvm/bin'],
  }

  ## run rvm-installer
  exec { 'global_gemrc_writer':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/ruby/_workaround/global_gemrc.pp --modulepath=/vagrant/puppet/modules/',
  }
}
