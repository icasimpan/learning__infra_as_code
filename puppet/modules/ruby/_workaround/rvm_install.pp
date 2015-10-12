## run rvm-installer
exec { 'rvm_installer_actual':
   environment => ["HOME=/home/vagrant"],
   command => '/usr/bin/curl -s https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer|/bin/bash',
   creates => "/home/vagrant/.rvm/scripts/rvm",
   user => 'vagrant',
}
