#Check and fix an issue with a wordpress instance runing a lamp stack

class apache_fix {

  # Ensure Apache and PHP are installed
  package { ['apache2', 'php', 'libapache2-mod-php']:
    ensure => installed,
  }

  # Ensure correct ownership and permissions for /var/www/html
  file { '/var/www/html':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    recurse => true,
    require => Package['apache2'],  # Ensure Apache is installed first
  }

  # Restart Apache to apply changes
  service { 'apache2':
    ensure    => running,
    enable    => true,
    subscribe => [ Package['apache2'], Package['php'], Package['libapache2-mod-php'], File['/var/www/html'] ],
  }
}

# Apply the fix
include apache_fix

