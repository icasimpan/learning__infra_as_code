include stdlib

file { '/etc/gemrc':
    ensure => 'present',
}->
file_line { 'no_docu_global_gemrc':
    path => '/etc/gemrc',
    line => 'gem: --no-document',
    match => '^gem:\ --no-document$',
}
