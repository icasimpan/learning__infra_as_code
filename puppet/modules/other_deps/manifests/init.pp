class other_deps {
  Package { ensure => "installed" }
  
  $other_deps_list = [ 
			'ImageMagick',
			'libxml2', 
			'libpq-dev',
			'g++',
			'make',
                        'git-core',
                        'curl',
                        'zlib1g-dev',
                        'build-essential',
                        'libssl-dev',
                        'libreadline-dev',
                        'libyaml-dev',
                        'libsqlite3-dev', 
                        'sqlite3',
                        'libxml2-dev', 
                        'libxslt1-dev',
                        'libcurl4-openssl-dev',
                        'python-software-properties',
                        'libffi-dev',
                        'vim',
                        'expect',
                        'debconf-utils',
                        'build-essential',
                        'zlib1g-dev',
                        'libreadline6-dev',
                        'libpcre3',
                      ]
  package { $other_deps_list: }
}
