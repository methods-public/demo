include_recipe 'nssm'

remote_file File.join(Chef::Config[:file_cache_path], node['syncGateway']['package_file']) do
  source node['syncGateway']['package_full_url']
  action :create_if_missing
end

case node['platform']
when 'windows'
    windows_package 'Couchbase Sync Gateway' do
        source File.join(Chef::Config[:file_cache_path], node['syncGateway']['package_file'])
        options "/s /v\"/qn AgreeToLicense=Yes INSTALLDIR=\\\"#{node['syncGateway']['install_dir'].gsub('/','\\\\')}\\\"\""
        installer_type :custom
        action :install
    end
end

template "#{node['syncGateway']['install_dir']}/config.json" do
    source 'config.json.erb'
    action :create
    notifies :restart, "windows_service[#{node['syncGateway']['service_name']}]"
end

case node['platform']
when 'windows'
    nssm "#{node['syncGateway']['service_name']}" do
        program "#{node['syncGateway']['install_dir']}\\syncGateway.exe"
        args %("""#{node['syncGateway']['install_dir']}\\config.json""")
        params(
            # DependOnService: 'CouchbaseServer',
            Start: 'SERVICE_DELAYED_AUTO_START'
        )
        start false
        action :install
    end

    windows_service "#{node['syncGateway']['service_name']}" do
        :start
    end
end

