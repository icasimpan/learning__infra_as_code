  exec { 'temp_tweak_permission_for_discourseLog':
    command => '/usr/bin/sudo /bin/chown vagrant:vagrant -R /opt/discourse',
  }->
  exec { 'discourse_dbseeding':
    command => "/usr/bin/sudo /bin/su vagrant -c '/usr/local/bin/bundle exec rake db:create db:migrate db:test:prepare'",
    cwd     => "/opt/discourse/app",
    tries   => '5',
    timeout => '0',
  }
