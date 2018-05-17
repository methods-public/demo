actions :create, :update, :delete
default_action :create

attribute :username, kind_of: String, required: true
attribute :password, kind_of: String, required: true
attribute :zone, kind_of: String, required: true
attribute :record_name, kind_of: String, required: true
attribute :record_type, kind_of: String, regex: /(A|CNAME)/i, required: true
attribute :record_value, kind_of: String
attribute :ttl, kind_of: Integer, default: 300
attribute :connection_options, default: {}