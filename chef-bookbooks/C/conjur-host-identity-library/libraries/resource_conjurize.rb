class Chef
    class Resource
        class Conjurize < Chef::Resource::LWRPBase
            self.resource_name = :conjurize

            attribute :netrc_path,         kind_of: String, default:  '/etc/conjur.identity'
            attribute :account,            kind_of: String, required: true
            attribute :appliance_url,      kind_of: String, required: true
            attribute :host_factory_token, kind_of: String, required: true
            attribute :ssl_certificate,    kind_of: String, required: true
            attribute :host_identity,      kind_of: String

            attribute :ssh,       kind_of: [TrueClass, FalseClass], default:  false
            attribute :overwrite, kind_of: [TrueClass, FalseClass], default:  false

            actions :run
            default_action :run
        end
    end
end