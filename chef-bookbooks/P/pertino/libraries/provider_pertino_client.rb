require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    # Pertino Client Provider
    #
    # Works hand-in-hand with the Pertino Client Resource
    # The provider does the heavy lifting, using Helpers for complex behaviors.
    #
    # @see Chef::Resource::PertinoClient
    # @see PertinoCookbook::Helpers
    # @since 0.1.0
    # @author Mike Fiedler <miketheman@gmail.com>
    class PertinoClient < Chef::Provider::LWRPBase
      include PertinoCookbook::Helpers

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :create do
        configure_package_repositories

        package 'pertino-client' do # ~FC009 `arch` is yum_package-specific
          # Some versions of CentOS choose the 32-bit package on 64-bit
          # platforms due to default yum policy being weird. Set arch to 64-bit
          # to prevent misbehaving, and allows for any variant of 32-bit.
          arch 'x86_64' if platform_family?('rhel') && node['kernel']['machine'] == 'x86_64'
          action :install
        end

        # Authenticate the Pertino Client via method specified
        #
        # @raise [SystemExit, Chef::Application.fatal!] exits the Chef run when no
        #   authentication mechanism is provided.
        # @todo only do this if there is no current auth method
        case new_resource.auth_mode
        when 'api_key'
          perform_device_auth(new_resource.api_key)
        when 'userpass'
          perform_user_auth(new_resource.username, new_resource.password)
        else
          Chef::Application.fatal!('Authentication method not recognized.')
        end

        # start service
        service 'pgateway' do
          action [:enable, :start]
        end
      end

      action :delete do
        package 'pertino-client' do
          action :remove
        end
      end
    end
  end
end
