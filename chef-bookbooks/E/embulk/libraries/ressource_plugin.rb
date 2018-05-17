# Chef Resource for installing an Embulk plugin
class EmbulkCookbook::PluginResource < Chef::Resource::LWRPBase
  include EmbulkCookbook::Helpers

  resource_name :embulk_plugin
  provides :embulk_plugin

  actions(:install, :uninstall)
  default_action :install if defined?(default_action)

  # if the name or url are different from the resource name
  attribute :name, kind_of: String, name_attribute: true
  attribute :user, kind_of: String, required: false, default: 'root'
  attribute :version, kind_of: String, required: false, default: nil
  attribute(:chef_proxy, kind_of: [TrueClass, FalseClass], default: true)

  # this is what helps the various resources find each other
  attribute(:instance_name, kind_of: String, default: nil)
end
