# This Puppet class ensures Apache is correctly installed and running
class apache_fix {

  package { ['apache2', 'php', 'libapache2-mod-php']:
    ensure => installed,
  }

  file { '/var/www/html':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    recurse => true,
    require => Package['apache2'],
  }

  service { 'apache2':
    ensure    => running,
    enable    => true,
    subscribe => [ Package['apache2'], Package['php'], Package['libapache2-mod-php'], File['/var/www/html'] ],
  }
}
