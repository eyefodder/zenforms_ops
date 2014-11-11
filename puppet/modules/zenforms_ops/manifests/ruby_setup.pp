# (c) 2014 Eyefodder, author: Paul Barnes-Hoggett
# This code is licensed under MIT license (see LICENSE.txt for details)
class zenforms_ops::ruby_setup{
  include apt
  # This is the repo available for Lucid, precise, raring, saucy & trusted
  # @ see http://www.ubuntuupdates.org/ppa/brightbox_ruby_ng_experimental
  apt::ppa{'ppa:brightbox/ruby-ng':
    before => Package['ruby_main'],
  }
  $ruby_dev_package = hiera('ruby::params::dev_package')
  $ruby_main_package = hiera('ruby::params::main_package')

  package{$ruby_main_package:
    ensure => installed,
    alias => 'ruby_main',
  } ->
  package{$ruby_dev_package:
    ensure => installed,
    alias => 'ruby',
  }

  package {'bundler':
    ensure  => 'installed',
    require => Package['ruby'],
    provider => 'gem',
  }

  package {'foreman':
    ensure  => 'installed',
    require => Package['ruby'],
    provider => 'gem',
  }

}