resource_name :dotnet_install
property :message, String, name_property: true
property :location, String, default: '/opt/dotnet.tar.gz'

case node['platform']
when 'ubuntu'
  property :apt_source, String, default: node['dotnet']['download']['apt']
when 'fedora'
  property :download_link, String, default: node['dotnet']['download']['link']+ node['dotnet']['download'][node['platform']][node['platform_version']]
else
  property :download_link, String, default: node['dotnet']['download']['link']+node['dotnet']['download'][node['platform']][node['platform_version'][0]]
end
property :key, String, default: ''
property :keyserver, String, default: ''
property :distribution, String, default: ''

default_action :create

load_current_value do
    if ::File.exist?(location.to_s)
        puts "Service Previous Installed - #{location}"
    end
end


action :install do
    directory "/opt/dotnet" do
      action :create
    end

    case node['platform_family']
    when 'debian'
        case node['platform']
        when 'debian'
            package %(curl libunwind8 gettext) do
                action :install
            end

            remote_file location do
              source download_link
              action :create
            end

            # extract the cookbook using terminal, do not to include the tar file cookbook
            execute 'extracting cookbook' do
                command "tar -xvf #{location} -C /opt/dotnet/"
            end

            link '/usr/local/bin/dotnet' do
                to '/opt/dotnet/dotnet'
                link_type :symbolic
                action :create
            end
        when 'ubuntu'
          apt_repository "dotnetdev" do
            uri apt_source
            components ['main']
            arch 'amd64'
            key '417A0893'
            keyserver 'keyserver.ubuntu.com'
            action :add
            deb_src false
          end

          package 'dotnet-dev-1.0.0-preview2.1-003177' do
            action :install
          end

        end

    when 'rhel'
        case node['platform']
        # FC024, not adding platform equivalents because instruction set is different based on distros
        when 'centos', 'fedora', 'oracle'
            package %w(libunwind libicu) do
                action :install
            end

            remote_file location do
              source download_link
              action :create
            end

            # extract the cookbook using terminal, do not to include the tar file cookbook
            execute 'extracting cookbook' do
                command "tar -xvf #{location} -C /opt/dotnet/"
            end

            link '/usr/local/bin/dotnet' do
                to '/opt/dotnet/dotnet'
                link_type :symbolic
                action :create
            end
        else
            execute 'enable .net core channel' do
                command 'subscription-manager repos --enable=rhel-7-server-dotnet-rpms'
            end

            package %w(scl-utils rh-dotnetcore10) do
                action :install
            end

            execute 'enable rh-dotnetcore10' do
                command 'scl enable rh-dotnetcore10 bash'
            end
        end
    end
end
