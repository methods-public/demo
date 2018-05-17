resource_name :hazelcast_plugin
default_action :install

property :source_url, String, default: lazy { 'https://www.igniterealtime.org/projects/openfire/plugins/hazelcast.jar' }
property :plugin_dir, String, required: false, default: lazy {
  ::File.join(node['openfire']['home_dir'], 'plugins')
}
property :cluster_members, Array, required: true

def plugin_filename
  ::File.join(plugin_dir, 'hazelcast.jar')
end
def hazel_cast_config
  ::File.join(node['openfire']['home_dir'], 'conf', 'hazelcast-cache-config.xml')
end
action :install do
  Chef::Log.info("loading Hazelcast clusting plugin from #{@new_resource.source_url}")

  remote_file plugin_filename do
    source source_url
    owner 'daemon'
    group 'daemon'
    mode '0644'
    notifies :restart, 'service[openfire]'
  end

  # enable clustering in the main conf file
  xml_edit '/opt/openfire/conf/openfire.xml' do
    parent '/jive'
    target '/jive/clustering'
    fragment <<-EOH
<clustering>
  <enabled>true</enabled>
</clustering>
EOH
    action :append_if_missing
  end


  # Write out the Hazel cast clsutering config
  template hazel_cast_config do
     user 'daemon'
     group 'daemon'
     cookbook 'ignite-openfire'
     variables(
       members: cluster_members
     )
  end
end

action :remove do

  Chef::Log.info("removing #{plugin_filename}")
  file plugin_filename do
    action :delete
    notifies :restart, 'service[openfire]'
  end
end
