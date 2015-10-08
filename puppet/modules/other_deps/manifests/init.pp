class other_deps {
  Package { ensure => "installed" }
  
  $other_deps_list = [ 
			'ImageMagick',
			'libxml2', 
			'libpq-dev',
			'g++',
			'make',
            ]
  package { $other_deps_list: }
}
