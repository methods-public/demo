#
# Cookbook:: vmware_tools
# Recipe:: default
#


virtual_system = node['virtualization']['system']

if virtual_system === 'vmware'

  platofrm_family = node['platform_family']

  case platofrm_family
    when 'debian', 'rhel'

      package 'open-vm-tools' do
        package_name 'open-vm-tools'
        action :upgrade
      end

    #when 'windows'
    # Choco package is realllly out of date skipping for now.
    # chocolatey_package '' do
    #  ignore_failure trues
    #  action :upgrade
    #   end

    else
      log 'Platform not supported' do
        message "The platform family: #{platofrm_family} is not supported by this recipe."
        level :warn
      end
  end

else

  log 'System Ignored' do
    message "The system: #{virtual_system} is not supported by this recipe."
    level :info
  end

end

