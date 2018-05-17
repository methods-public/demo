class Chef
  class Resource
    class CouchBase < Chef::Resource::LWRPBase
      self.resource_name = :couch_base

      attribute :host, kind_of: String, default: '127.0.0.1'
      attribute :port, kind_of: [String, Integer], default: 5984
      attribute :admin, kind_of: String
      attribute :password, kind_of: String
      attribute :secure, kind_of: [TrueClass, FalseClass], default: false
      attribute :verify_ssl, kind_of: [TrueClass, FalseClass], default: true
    end
  end
end
