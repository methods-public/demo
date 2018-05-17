require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class CouchConfig < Chef::Resource::LWRPBase
      self.resource_name = :couch_config
      default_action :create
      actions [
        :create,
        :delete
      ]

      attribute :source, kind_of: String, required: true
      attribute :options, kind_of: Hash, default: {}
    end
  end
end
