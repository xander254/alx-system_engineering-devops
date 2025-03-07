class nginx_limits_fix {

  # Ensure the Nginx config file exists with proper file limits
  file { '/etc/nginx/nginx.conf':
    ensure  => file,
    content => template('nginx/nginx.conf.erb'),
    mode    => '0644',
    require => Package['nginx'],
  }

  # Set system-wide file limits for Nginx
  file_line { 'set_nginx_nofile_limits':
    path   => '/etc/security/limits.conf',
    line   => 'nginx soft nofile 1048576',
    match  => '^nginx.*nofile',
    ensure => present,
  }

  file_line { 'set_nginx_hard_limits':
    path   => '/etc/security/limits.conf',
    line   => 'nginx hard nofile 1048576',
    match  => '^nginx.*nofile',
    ensure => present,
  }

  # Adjust SystemD service limits for Nginx
  file { '/etc/systemd/system/nginx.service.d/override.conf':
    ensure  => file,
    content => "[Service]\nLimitNOFILE=1048576\n",
    mode    => '0644',
    require => Package['nginx'],
  }

  # Reload systemd and restart Nginx
  exec { 'reload-systemd':
    command     => '/bin/systemctl daemon-reexec',
    refreshonly => true,
    subscribe   => File['/etc/systemd/system/nginx.service.d/override.conf'],
  }

  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => File['/etc/nginx/nginx.conf'],
    subscribe  => File['/etc/nginx/nginx.conf'],
  }

}

# Apply the class
include nginx_limits_fix

