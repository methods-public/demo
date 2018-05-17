# resource_name :openfire_plugin
# default_action :install
#
# property :source_url, String, required: true
# property :plugin_name, String, name_property: true, required: true
# property :plugin_dir, String, required: false, default: lazy {
#   ::File.join(default['openfire']['home_dir'], 'plugins')
# }
# property :openfire_user, String, default: lazy { node['openfire']['user'] }
# property :openfire_group, String, default: lazy { node['openfire']['group'] }
#
# action :install do
#   unless @current_resource.exists
#     Chef::Log.info("loading #{plugin_name} from #{@new_resource.source_url}")
#     remote_file plugin_name do
#       source new_resource.source_url
#       owner openfire_user
#       group openfire_group
#       mode '0750'
#       notifies :restart, "service[openfire]"
#     end
#     @new_resource.updated_by_last_action(true)
#   end
# end
#
# action :remove do
#   if @current_resource.exists
#     Chef::Log.info("removing #{plugin_filename}")
#     file plugin_filename do
#       action :delete
#       notifies :restart, "service[Openfire]"
#     end
#     @new_resource.updated_by_last_action(true)
#   end
# end
#
# def load_current_resource
#   @current_resource = Chef::Resource::OpenfirePlugin.new(@new_resource.name)
#   @current_resource.name(@new_resource.name)
#   @current_resource.source(@new_resource.source)
#
#   @current_resource.exists = true if ::File.exist?(plugin_filename)
# end
#
#
# def plugin_filename
#   "#{node['openfire']['plugin_dir']}/#{new_resource.name}.jar"
# end
