resource_name :go
property :name   , String, name_property: true
property :version, String, default: '1.9.2'
property :platform,String, default: node['kernel']['machine'] =~ /i.86/ ? '386' : 'amd64'
property :url, [String, NilClass], default: nil
property :install_dir, String, default: '/usr/local/'
property :project_dir, [String, NilClass], default: nil
property :gopath, String, default: "go/src"
property :gobin,  String, default: "go/bin"
property :perms,  String, default: "0777"

default_action :install
action :install do
  include_recipe 'tar'
  include_recipe 'git::default'

  unless project_dir.nil?
    directory project_dir do
      owner 'root'
      group 'root'
      mode  '0755'
      action :create
    end
  end

  if url.nil?
    Chef::Log.warn('Default Link for GoLang will be used as it was not explicitely set.')
    url = "https://golang.org/dl/go#{version}.#{node['os']}-#{platform}.tar.gz"
  end
  tar_extract url do
    target_dir install_dir
  end

  [gopath, gobin, 'pkg'].each do |dir|
    directory "#{install_dir}#{dir}" do
      mode perms
      recursive true
      action :create
    end
  end

  template "/etc/profile.d/path.sh" do
    source 'path.sh.erb'
    cookbook 'go_chef'
    variables ({installpath: install_dir + "go/bin",
               golang_path:  install_dir + gopath,
               golang_bin:   install_dir + gobin})
    not_if { ::File.exist?('/etc/profile.d/path.sh') }
  end
end
