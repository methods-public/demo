# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :machine
    config.cache.auto_detect = false
    config.cache.enable :chef
    config.cache.enable :chef_gem
    config.cache.enable :yum
  end

  config.vm.box = 'chef/centos-6.6'
  config.vm.box_check_update = true

  config.vm.hostname = 'artifactory-ppro'
  config.vm.network 'forwarded_port', guest: '8081', host: '8081'

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
    vb.cpus = 1
  end

  config.vm.provision 'chef_zero' do |chef|
    chef.install = true

    chef.run_list = %w(
      recipe[artifactory_pro::default]
    )
  end
end
