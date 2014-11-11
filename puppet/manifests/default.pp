# (c) 2014 Eyefodder, author: Paul Barnes-Hoggett
# This code is licensed under MIT license (see LICENSE.txt for details)
Exec {
  path => "/usr/bin:/usr/local/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/vagrant_ruby/bin"
}
include zenforms_ops::base_packages
include zenforms_ops::postgres_setup
include zenforms_ops::ruby_setup
include zenforms_ops::dotfile_symlink