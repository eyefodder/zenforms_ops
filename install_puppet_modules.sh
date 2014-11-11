#!/usr/bin/env bash
# (c) 2014 Eyefodder, author: Paul Barnes-Hoggett
# This code is licensed under MIT license (see LICENSE.txt for details)

echo 'updating package list'
apt-get update >/dev/null 2>&1
echo 'updated'

echo 'installing puppet'
gem update puppet --no-rdoc --no-ri

if [ ! -e "/etc/puppet/modules/apt/" ]; then
  echo 'installing apt module'
  puppet module install puppetlabs-apt --modulepath /etc/puppet/modules
else
  echo 'apt module already installed'
fi

if [ ! -e "/etc/puppet/modules/postgresql/" ]; then
  echo 'installing postgresql module'
  puppet module install puppetlabs-postgresql --modulepath /etc/puppet/modules
else
  echo 'postgresql module already installed'
fi
