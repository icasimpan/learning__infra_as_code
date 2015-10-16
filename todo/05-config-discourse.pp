  exec { 'temp_tweak_permission_for_jsondiscourse01':
    command => '/usr/bin/sudo /bin/chmod o+w -R /usr/local/lib/ruby/gems/2.2.0/',
  }->
  exec { 'temp_tweak_permission_for_jsondiscourse02':
    command => '/usr/bin/sudo /bin/chmod o+w /usr/local/bin',
  }->
  exec { 'bundle_install_discourse':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/local/bin/bundle install'",
    cwd     => "/opt/discourse",
    tries   => '5',
    timeout => '0',
  }
