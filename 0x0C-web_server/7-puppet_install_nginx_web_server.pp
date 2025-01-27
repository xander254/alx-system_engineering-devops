#Set up a new ubuntu server

exec { 'update the system':
    command => 'usr/bin/apt-get update',
}

package { 'nginx':
    ensure => 'installed',
    require => Exec['update the system']
}

file { '/var/www/html/index.html':
    content => 'Hello World!'
}

exec { 'redirect':
    command => 'sed -i "241\        rewrite ^/redirect https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-available/default'
        provider => 'shell'
}

service { 'ngix':
    ensure => running,
    require => package['nginx']
}
