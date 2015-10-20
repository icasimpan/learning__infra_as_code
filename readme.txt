QUICK GUIDE:

Assuming you have a properly setup vagrant and virtualbox:

1. git clone https://github.com/icasimpan/learning__infra_as_code.git
2. vagrant up
3. In about 30-40mins, access discourse from http://<eth1_ip_address>, replacing of course <eth1_ip_address> with real value

EXPLANATION:

As we know, the file 'Vagrantfile' is what dictates what the initial behavior of vagrant.
Inside, there is a provisioner which is through shell script. It is named vagrant_provision.sh.

Within vagrant_provision.sh, you'll notice that it's actually puppet that does the real provisioning.
It gets the instructions from the main manifest file (/vagrant/puppet/manifests/init.pp) where modules
are defined and loaded in sequence using this line:

	Class['nginx']->Class['redis']->Class["postgres::install"] -> Class["postgres::config"] -> Class["postgres::service"]->Class['ruby']->Class['discourse']

In each module, needed instructions and dependencies are listed in each modules/init.pp. Once everything is run in about 30-40mins, discourse is properly viewable in http://<eth1_ip_address>


EXPERIMENTAL:
In module discourse, do the following to test with email:
 1. Do not close yet the permissions
 2. gem install mailcatcher (as 'vagrant' user)
 3. run 'mailcatcher' (as 'vagrant' user)
 4. run 'sidekiq -d -L /opt/discourse/log/sidekiq.log' (as 'vagrant' user)
 5. So far, I didn't have success in using mailcatcher
