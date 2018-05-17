node_build_standalone_install 'node-build'

user 'user-with-node-build' do
  home '/home/user-with-node-build'
  manage_home true
  action :create
end

node_build_plugin_install ::File.join('/home/user-with-node-build', 'plugins', 'node-build')
