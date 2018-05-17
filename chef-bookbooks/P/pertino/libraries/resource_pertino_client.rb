require 'chef/resource/lwrp_base'

class Chef
  class Resource
    # Pertino Client Resource
    #
    # Serves as the user-facing API.
    # Works hand-in-hand with the Pertino Client Provider.
    #
    # @see Chef::Provider::PertinoClient
    # @since 0.1.0
    # @author Mike Fiedler <miketheman@gmail.com>
    class PertinoClient < Chef::Resource::LWRPBase
      self.resource_name = :pertino_client
      actions :create, :delete
      default_action :create

      attribute :auth_mode, kind_of: String, required: true, default: 'api_key' # or 'userpass'

      attribute :api_key, kind_of: String, default: nil
      attribute :username, kind_of: String, default: nil
      attribute :password, kind_of: String, default: nil
    end
  end
end
