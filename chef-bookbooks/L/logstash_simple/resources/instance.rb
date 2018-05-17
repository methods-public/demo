property :package_type, String, default: 'tarball'
property :package_url, String, default: ''
property :package_checksum, String, default: ''
property :logstash_directory, String, default: ''
property :logstash_version, String, default: ''
property :logstash_log_directory, String, default: ''
property :logstash_config_directory, String, default: ''
property :logstash_user, String, default: ''
property :logstash_group, String, default: ''
property :logstash_heap_size, String, default: ''

action :create do

  # Download the Logstash package at the given URL and store in the Chef cache
  remote_file "#{Chef::Config[:file_cache_path]}/logstash.package" do
    source package_url
    checksum package_checksum
    action :create
  end

  if package_type == 'tarball'

    template '/tmp/logstash_install.sh' do
      source 'logstash_install.sh.erb'
      owner 'root'
      group 'root'
      mode '0755'
      cookbook 'logstash_simple'
      variables ({
          :l_directory => logstash_directory,
          :l_version => logstash_version,
          :l_package => "#{Chef::Config[:file_cache_path]}/logstash.package",
          :l_log_directory => logstash_log_directory,
          :l_config_directory => logstash_config_directory,
          :l_user => logstash_user,
          :l_group => logstash_group
      	})
    end
  
  	execute 'install_logstash' do
  	  command 'bash /tmp/logstash_install.sh'
  	  creates logstash_directory
  	  action :run
  	end

  	template '/etc/default/logstash' do
      source 'logstash.environment.erb'
      owner 'root'
      group 'root'
      mode '0644'
      cookbook 'logstash_simple'
  	  variables ({
          :l_directory => logstash_directory,
          :l_version => logstash_version,
          :l_log_directory => logstash_log_directory,
          :l_config_directory => logstash_config_directory,
          :l_user => logstash_user,
          :l_group => logstash_group,
          :l_heap_size => logstash_heap_size
  	  	})
  	end
  	
  	
  	template '/etc/systemd/system/logstash.service' do
  	  source 'logstash.service.erb'
  	  owner 'root'
  	  group 'root'
  	  mode '0755'
      cookbook 'logstash_simple'
  	  variables ({
                  :l_directory => logstash_directory
  	  	})
  	end
  	
  end
  if package_type == 'rpm'
  
    # Intall Logstash.package stored in cache
    rpm_package 'logstash.package' do
      source "#{Chef::Config[:file_cache_path]}/logstash.package"
      action :install
    end
  end
  if package_type == 'deb'
  
  end

end
