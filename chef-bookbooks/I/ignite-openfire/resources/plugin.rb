resource_name :openfire_plugin
default_action :install

property :source_url, String, required: true
property :plugin_name, String, name_property: true, required: true
property :plugin_dir, String, required: false, default: lazy {
  ::File.join(node['openfire']['home_dir'], 'plugins')
}
property :openfire_user, String, default: lazy { 'daemon' }
property :openfire_group, String, default: lazy { 'daemon' }

action :install do
  Chef::Log.info("loading #{plugin_name} from #{@new_resource.source_url}")
  remote_file plugin_name do
    path "#{plugin_dir}/#{plugin_name}.jar"
    source source_url
    owner openfire_user
    group openfire_group
    mode '0644'
    notifies :restart, 'service[openfire]'
  end
end

action :remove do
  Chef::Log.info("removing #{plugin_filename}")
  file plugin_filename do
    action :delete
    notifies :restart, 'service[openfire]'
  end
end

def plugin_filename
  ::File.join(plugin_dir, name)
end
