class nginx_module (
  $port = 80,
  $document_root = '/usr/share/nginx/html',
) {
  package { 'nginx':
    ensure => installed,
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

  file { $document_root:
    ensure => directory,
  }

  file { "${document_root}/index.html":
    ensure  => present,
    content => 'Hello, Puppet World!',
  }

  file { '/etc/nginx/nginx.conf':
    ensure  => present,
    content => template('nginx_module/nginx.conf.erb'),
    notify  => Service['nginx'],
  }

  firewall { '80':
    ensure  => present,
    dport   => $port,
    proto   => tcp,
    action  => accept,
  }
}
