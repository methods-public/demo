class Chef
  class Resource
    class CouchQuery < Chef::Resource::CouchBase
      self.resource_name = :couch_query
      default_action :post
      actions [:post, :put, :get, :delete]

      attribute :urn, kind_of: String, name_attribute: true
      attribute :body, kind_of: [ String, Hash ]
      attribute :response_code, kind_of: String
    end
  end
end
