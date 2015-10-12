## clone discourse to /opt/discourse
exec { 'git_clone_discourse':
  command => '/usr/bin/git clone https://github.com/discourse/discourse.git /opt/discourse',
}->
exec { 'recursive_discourse_chown4vagrant':
  command => '/bin/chown -R vagrant:vagrant /opt/discourse',
}
