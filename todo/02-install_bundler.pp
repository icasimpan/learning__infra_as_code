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
    command => "/usr/bin/sudo /bin/su -c '/usr/local/bin/gem install bundler'",
  }

