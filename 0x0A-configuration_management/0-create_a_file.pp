# This manifest ensures the file /tmp/school exists with specific content, ownership, and permissions
node default {
  file { '/tmp/school':
    ensure  => 'present',
    content => 'I love puppet',
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0744',
  }
}
