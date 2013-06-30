exec { "apt-get update":
    path => "/usr/bin",
}
package { "libxml2-dev":
    require => Exec["apt-get update"],
    ensure  => present,
}
package { "libxslt1-dev":
    require => Exec["apt-get update"],
    ensure  => installed,
}
package { "make":
    require => Exec["apt-get update"],
    ensure  => present,
}
package { "libmysqlclient-dev":
    require => Exec["apt-get update"],
    ensure  => present,
}
package { "rake":
    require => Package["ruby1.9.3"],
    ensure  => present,
}
package { "ruby1.9.3":
    require => Exec["apt-get update"],
    ensure  => installed,
}
package { "ruby-bundler":
    require => Package["ruby1.9.3"],
    ensure  => installed,
}
package { "gem":
    require => Package["ruby1.9.3"],
    ensure  => installed,
}
package { "rails":
    require => Package["ruby1.9.3"],
    ensure  => installed,
}
exec { "rm /usr/bin/ruby":
    path      => "/bin",
    require   => [Package["gem"], Package["ruby-bundler"], Package["rake"], Package["rails"]],
}
file { "/usr/bin/ruby":
    require => Exec["rm /usr/bin/ruby"],
    ensure => 'link',
    target => '/usr/bin/ruby1.9.3',
}
exec { "bundle install":
    path      => "/usr/bin",
    cwd       => "/vagrant",
    require   => [File["/usr/bin/ruby"], Package["libmysqlclient-dev"], Package["make"], Package["libxml2-dev"], Package["libxslt1-dev"]],
    logoutput => true,
}
