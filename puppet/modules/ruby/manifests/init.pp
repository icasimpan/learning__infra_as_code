class ruby {
  exec { "install_ruby_223":
    command => "rbenv install 2.2.3",
    path    => '/usr/local/rbenv/bin',
  }

  exec { "global_ruby_223":
    command => "rbenv global 2.2.3",
    path    => '/usr/local/rbenv/bin',
  }
}
