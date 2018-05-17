class Chef
  class Resource
    class CouchReplication < Chef::Resource::CouchBase
      self.resource_name = :couch_replication
      default_action :create
      actions [:create]

      attribute :source, kind_of: String, name_attribute: true
      attribute :target, kind_of: String, required: true
      attribute :replicator_db, kind_of: String, default: '_replicator'
      attribute :continuous, kind_of: [TrueClass, FalseClass], default: false
      attribute :create_target, kind_of: [TrueClass, FalseClass]
      attribute :doc_ids, kind_of: Array
      attribute :proxy, kind_of: String
      attribute :since_seq, kind_of: Integer
      attribute :filter, kind_of: String
      attribute :query_params, kind_of: Hash
      attribute :use_checkpoints, kind_of: [TrueClass, FalseClass]
      attribute :checkpoint_interval, kind_of: Integer
    end
  end
end
