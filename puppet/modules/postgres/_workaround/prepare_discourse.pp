exec { 'prepare_pgsql_discourse01':
  command => "/usr/bin/psql -c \"ALTER USER vagrant WITH PASSWORD 'password';\"",
  user    => 'postgres',
} ->
exec { 'prepare_pgsql_discourse02':
  command => "/usr/bin/psql -c \"create database discourse_development owner vagrant encoding 'UTF8' TEMPLATE template0;\"",
  user    => 'postgres',
} ->
exec { 'prepare_pgsql_discourse03':
  command => "/usr/bin/psql -c \"create database discourse_test owner vagrant encoding 'UTF8' TEMPLATE template0;\"",
  user    => 'postgres',
} ->
exec { 'prepare_pgsql_discourse04':
  command => "/usr/bin/psql -d discourse_development -c \"CREATE EXTENSION hstore;\"",
  user    => 'postgres',
} ->
exec { 'prepare_pgsql_discourse05':
  command => "/usr/bin/psql -d discourse_development -c \"CREATE EXTENSION pg_trgm;\"",
  user    => 'postgres',
}
