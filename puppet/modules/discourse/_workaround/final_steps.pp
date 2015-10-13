#### THIS PART FINALLY WORKING!!!!!
exec { 'install_gem_bundle':
  environment => ['HOME=/home/vagrant'],
  cwd         => '/opt/discourse/app',
  command     => '/home/vagrant/.rvm/rubies/ruby-2.2.3/bin/gem install bundle --install-dir /home/vagrant/.rvm/gems/ruby-2.2.3',
  tries       => '5',
}->
exec { 'ensure_discourse_correct_ownership00':
  command => '/bin/chown -R vagrant:rvm /opt/discourse',
  tries   => '5',
}->
exec { 'ensure_bundle_perm2vagrant':
  command => '/bin/chown -R vagrant:rvm /home/vagrant/.rvm',
  tries   => '5',
}

### 2 MORE TO GO...
# cd /opt/discourse; /home/vagrant/.rvm/gems/ruby-2.2.3/bin/bundle install
#cd /opt/discourse; /home/vagrant/.rvm/gems/ruby-2.2.3/bin/bundle exec rake db:create db:migrate db:test:prepare
