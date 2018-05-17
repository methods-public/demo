class Chef
  class Resource
    class CouchDatabase < Chef::Resource::CouchBase
      self.resource_name :couch_database
      default_action :create
      actions [:create, :delete]

      attribute :database, kind_of: String, name_attribute: true, required: true, regex: /^[a-z][a-z0-9_$()+\/-]*$/
    end
  end
end
