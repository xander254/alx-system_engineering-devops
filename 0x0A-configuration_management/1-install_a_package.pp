#Install Flask using pip3
node default {
    package { 'python3-pip':
      ensure => installed,
    }

    exec { 'install_flask_2.1.0':
      command => '/usr/bin/pip3 install flask==2.1.0',
      path    => ['/usr/bin', '/bin'],
      unless  => '/usr/bin/pip3 show flask | grep "Version: 2.1.0"',
      require => Package['python3-pip'],
    }
}
