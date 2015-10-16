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
  package { $ruby_deps_list: }

  ## added locale settings
  exec { 'append_etc_bash.bashrc':
    command => '/usr/bin/sudo /usr/bin/puppet apply /vagrant/puppet/modules/ruby/_workaround/append__etc_bash.bashrc  --modulepath=/vagrant/puppet/modules',
  }
