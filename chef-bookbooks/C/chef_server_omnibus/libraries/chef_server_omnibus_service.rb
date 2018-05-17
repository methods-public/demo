require 'poise'

class Chef
  class Resource
    class ChefServerOmnibusService < Resource::Service
      include Poise

      attribute :reconfigure_command, kind_of: String, required: true

      def initialize(name, run_context = nil)
        super
        @resource_name = :chef_server_omnibus_service
        @allowed_actions.push(:reconfigure)
        # @reconfigure_command = nil
      end
    end
  end

  class Provider
    class ChefServerOmnibusService < Provider::Service::Simple
      include Poise

      def action_reconfigure
        converge_by("reconfigure service #{@new_resource}") do
          shell_out!(@new_resource.reconfigure_command)
          Chef::Log.info("#{@new_resource} reconfigured")
        end
        load_new_resource_state
        @new_resource.running(true)
      end
    end
  end
end
