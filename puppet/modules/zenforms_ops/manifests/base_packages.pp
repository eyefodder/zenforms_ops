# (c) 2014 Eyefodder, author: Paul Barnes-Hoggett
# This code is licensed under MIT license (see LICENSE.txt for details)
class zenforms_ops::base_packages{
  class { 'apt':
    always_apt_update    => true,
  }

  package { "build-essential":
    ensure => installed,
  }

  package { "zlib1g-dev":
    ensure => installed,
  }
  package { "libssl-dev":
    ensure => installed,
  }
  package { "libreadline-dev":
    ensure => installed,
  }
  package { "git-core":
    ensure => installed,
  }
  package { "curl":
    ensure => installed,
  }
  package { "libyaml-dev":
    ensure => installed,
  }
  package { "libcurl4-openssl-dev":
    ensure => installed,
  }
  package { "libsqlite-dev":
    ensure => installed,
  }
  package { "libsqlite3-ruby":
    ensure => installed,
  }
  package { "postgresql":
    ensure => installed,
  }
  package { "libpq-dev":
    ensure => installed,
  }
  package { "sqlite3":
    ensure => installed,
  }
  package { "libsqlite3-dev":
    ensure => installed,
  }
  package { "bcrypt":
    ensure => installed,
  }
  package { "libnotify-bin":
    ensure => installed,
  }
  package { "libqtwebkit-dev":
    ensure => installed,
  }
}