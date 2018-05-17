require 'poise'

class Chef
  class Resource
    class GitlabOmnibusService < Resource::Service
      include Poise

      def initialize(name, run_context = nil)
        super
        @resource_name = :gitlab_omnibus_service
        @allowed_actions.push(:reconfigure)
        @reconfigure_command = nil
      end

      def reconfigure_command(arg = nil)
        set_or_return(
          :reconfigure_command,
          arg,
          kind_of: [String]
        )
      end
    end
  end

  class Provider
    class GitlabOmnibusService < Provider::Service::Simple
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
