exec { 'create_user':
  command => '/usr/bin/createuser vagrant -s',
  user => 'postgres',
}
