include nginx
include redis
include postgres
include ruby
include discourse

### explicitly stated module loading sequence by puppet
Class['nginx']->Class['redis']->Class["postgres::install"] -> Class["postgres::config"] -> Class["postgres::service"]->Class['ruby']->Class['discourse']
