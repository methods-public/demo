property :prefix, String, default: '/usr/local'

action :install do
  node_build_plugin_install node_build_cache do
    user 'root'
  end

  execute "node-build standalone install #{new_resource.prefix}" do
    cwd node_build_cache
    command 'sh install.sh'
    environment('PREFIX' => new_resource.prefix)
    creates node_build_binary
  end
end

action_class do
  def node_build_cache
    ::File.join(Chef::Config[:file_cache_path], 'node-build')
  end

  def node_build_binary
    ::File.join(new_resource.prefix, 'share', 'node-build', 'bin', 'node-build')
  end
end
