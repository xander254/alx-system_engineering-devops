# Use exec to kill the "killmenow" process
node default {
  exec { 'kill_process_killmenow':
    command => '/usr/bin/pkill killmenow',
    path    => ['/usr/bin', '/bin'],
    onlyif  => '/usr/bin/pgrep killmenow',
  }
}

