#
# To get this to run properly, you need to restart the machine before running the provisioner
# ```
# vagrant up --no-provision
# vagrant reload
# ```
Vagrant.configure(2) do |config|
  config.vm.box = "joshbeard/windows_2008_r2"
  config.omnibus.chef_version = :latest
  config.vm.guest = :windows
  config.vm.communicator = :winrm
  
  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
  end
  
  config.vm.network "public_network", bridge: "en3: Thunderbolt Ethernet"
  
  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = ['~/chef-repo/cookbooks', '~/chef-repo/site-cookbooks']
    chef.add_recipe 'vc2013'
  end
end