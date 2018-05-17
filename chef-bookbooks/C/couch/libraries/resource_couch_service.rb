require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class CouchService < Chef::Resource::LWRPBase
      self.resource_name = :couch_service
      default_action :create
      actions [
        :create,
        :start,
        :delete,
        :stop,
        :restart
      ]

      attribute :port, kind_of: [String, Integer], default: 5984
      attribute :bind_address, kind_of: String, default: '127.0.0.1'
      attribute :from_package, kind_of: [TrueClass, FalseClass], default: false
      attribute :source_version, kind_of: String, default: '1.6.1'
      attribute :source_url, kind_of: String, default: 'http://archive.apache.org/dist/couchdb/source/1.6.1/'
      attribute :source_checksum, kind_of: String, default: '5a601b173733ce3ed31b654805c793aa907131cd70b06d03825f169aa48c8627'
      attribute :source_package, kind_of: String, default: 'apache-couchdb-1.6.1.tar.gz'
      attribute :package_version, kind_of: String
      attribute :path_prefix, kind_of: String, default: '/opt/couchdb'
    end
  end
end
