ubuntu_box_name = 'opscode_ubuntu-12.04_chef-11.2.0'
ubuntu_box_url  = "https://opscode-vm.s3.amazonaws.com/vagrant/#{ubuntu_box_name}.box"
windows_box_name = 'vagrant-windows2008r2'
windows_box_url = "http://REPLACE_ME/#{windows_box_name}.box"
api_version = '2'

Vagrant::configure(api_version) do |config|
  config.berkshelf.enabled    = true

  config.vm.define 'ubuntu', primary: true do |ubuntu|
    ubuntu.vm.box               = ubuntu_box_name
    ubuntu.vm.box_url           = ubuntu_box_url

    ubuntu.vm.provider :virtualbox do |v|
      v.customize ['modifyvm', :id, '--memory', '1024']
    end

    ubuntu.vm.network :private_network, ip: '192.168.192.2'

    ubuntu.vm.provision :chef_solo do |chef|
      chef.log_level = 'info'
      chef.json = {
          'vmware_workstation' => {
              'accept_eula' => true,
              'serial_number' => 'REPLACE_ME',
              'install_file' => 'VMware-Workstation-Full-10.0.2-1744117.x86_64.bundle',
              'source_prefix' => 'REPLACE_ME',
              'checksum' => 'f32b72ecfc8b808731e97c3d478a1cda78427aaf'
          }
      }

      chef.run_list = [
          'vmware_workstation',
          'minitest-handler'
      ]
    end
  end

  config.vm.define 'windows', autostart: false do |windows|
    windows.vm.box               = windows_box_name
    windows.vm.box_url           = windows_box_url

    windows.vm.provider :virtualbox do |v|
      v.gui = true
    end

    windows.vm.communicator = :winrm

    windows.vm.provision :chef_solo do |chef|
      chef.log_level = 'info'
      chef.json = {
          'vmware_workstation' => {
              'accept_eula' => true,
              'serial_number' => 'REPLACE_ME',
              'install_file' => 'VMware-workstation-full-10.0.2-1744117.exe',
              'source_prefix' => 'REPLACE_ME',
              'checksum' => 'f7826612ceccadf2f6b09b24305c16c32865e48e'
          }
      }

      chef.run_list = [
          'vmware_workstation'
      ]
    end
  end

end
