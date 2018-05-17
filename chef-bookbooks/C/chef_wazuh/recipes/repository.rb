#
# Cookbook:: chef_wazuh
# Recipe:: repository
#
# MIT

if %w(debian ubuntu redhat centos).include? node['platform']

  if node['platform_family'] == 'debian'
    # Deb stuff

    # Remove previous OSSEC
    package 'ossec-hids-agent' do
      action :purge
    end

    # Install prerequisites
    %w(curl apt-transport-https lsb-release).each do |pkg|
      package pkg do
        action :install
      end
    end

    # Add apt repo
    apt_repository 'wazuh' do
      uri 'https://packages.wazuh.com/3.x/apt/'
      key 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
      distribution nil
      components %w(stable main)
    end

  elsif node['platform_family'] == 'rhel'
    # RHEL stuff

    if node['platform_version'] =~ /5\.*/
      # RHEL 5 only

      # Use the RHEL 5 yum repo
      yum_repository 'Wazuh repository' do
        gpgcheck 1
        gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
        baseurl 'https://packages.wazuh.com/3.x/yum/5/'
        enabled 1
        action :create
      end

    else
      # All other RHEL versions

      # Use the default yum repo
      yum_repository 'Wazuh repository' do
        gpgcheck 1
        gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
        baseurl 'https://packages.wazuh.com/3.x/yum/'
        enabled 1
        action :create
      end

    end

  end

else

  # Warn that the platform this was run on is not supported
  log 'chef_wazuh::platform::warning' do
    message "Platform: \"#{node['platform']}\" is not supported. Moving on..."
    level :warn
  end

end