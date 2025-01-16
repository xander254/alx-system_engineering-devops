# A Puppet manifest to set the SSH connection to use a specific key and disable password authentication
node '100.25.37.14' {
  file { '/home/ubuntu/.ssh/config': # Absolute path to the SSH config file
    ensure  => file,
    content => @("EOT"),
Host 100.25.37.14
  Hostname 100.25.37.14
  User ubuntu
  IdentityFile ~/.ssh/school
  PasswordAuthentication no
  Port 22
| EOT
    owner   => 'ubuntu',
    group   => 'ubuntu',
    mode    => '0600',
  }
}

