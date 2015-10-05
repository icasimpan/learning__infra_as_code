class git {
  # Install the git package. This relies on apt-get update
  package { 'git':
    ensure => 'present',
    require => Exec['apt-get update'],
  }
}
