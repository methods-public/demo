include_recipe 'build-essential'
include_recipe 'git'

node['mono3']['source']['dependencies'].each { |d| package d }

installation_dir = '/usr/local/src/mono'

directory installation_dir do
  owner 'root'
  group 'root'
  mode '0777'
  action :create
end

git 'mono' do
  repository node['mono3']['source']['git_uri']
  reference node['mono3']['source']['git_branch']
  destination installation_dir
  action :sync
end

bash "build_mono" do
  user 'root'
  cwd installation_dir
  code <<-EOH
    ./autogen.sh --prefix=/usr/local --with-libgdiplus=/usr/lib/
    make get-monolite-latest
    make EXTERNAL_MCS="${PWD}/mcs/class/lib/monolite/gmcs.exe"
    make
    make install
  EOH
end
