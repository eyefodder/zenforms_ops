# -*- mode: ruby -*-
# vi: set ft=ruby :

# (c) 2014 Eyefodder, author: Paul Barnes-Hoggett
# This code is licensed under MIT license (see LICENSE.txt for details)

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "eyefodder/precise64-utf8"
  config.vm.host_name = 'zenforms'

  config.vm.network :forwarded_port, guest: 3000, host: 3000, auto_correct: true

  config.vm.synced_folder "./puppet", "/etc/puppet"
  config.vm.synced_folder 'dotfiles', '/dotfiles'
  config.vm.synced_folder '../zenforms/reports', '/reports'
  config.vm.synced_folder "../zenforms", "/app", type: "rsync", rsync__exclude: [".git/", "ops/*", "reports/", "tmp/", "log/", ".#*"]

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
    vb.name = 'zenforms'
  end

  config.vm.provision 'shell', path: 'install_puppet_modules.sh'
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path =  "puppet/manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = 'puppet/modules'
    puppet.hiera_config_path = "puppet/hiera.yaml"
    puppet.working_directory = "/etc/puppet"
  end

  config.trigger.before [:up, :reload], :stdout => true do
    run "mkdir -p ../zenforms/reports"
    run "sh ./setup_guest_bash_profile.sh"
  end

  # EACH UP PROVISIONING
  config.vm.provision 'shell', path: 'prep_rails_app.sh', privileged: false, run: 'always'

end
