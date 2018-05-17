require 'uri'
require 'chef/provider/lwrp_base'

require_relative 'helpers'

class Chef
  class Provider
    class CouchConfig < Chef::Provider::LWRPBase
      include Couch::Helpers
      use_inline_resources if defined?(use_inline_resources)

      action :create do
        c = template "couch_config_#{new_resource.name}_create" do
          action :create
          path ini_file
          owner 'couchdb'
          group 'couchdb'
          variables new_resource.options
          source new_resource.source
          cookbook new_resource.cookbook_name.to_s
        end
        c.run_action :create
        new_resource.updated_by_last_action(c.updated_by_last_action?)
      end

      action :delete do
        c = file "couch_config_#{new_resource.name}_remove" do
          action :delete
          path ini_file
        end
        c.run_action :delete
        new_resource.updated_by_last_action(c.updated_by_last_action?)
      end

      def ini_file
        return @ini_file unless @ini_file.nil?
        @ini_file = ::File.join(local_ini_dir(couch_service_resource),
                                "#{new_resource.name}.ini")
        @ini_file
      end

      def couch_service_resource
        return @couch_service_resource unless @couch_service_resource.nil?
        new_resource.run_context.resource_collection.each do |resource|
          if resource.is_a?(Chef::Resource::CouchService)
            if resource.action.kind_of?(Array)
              action = resource.action
            else
              action = [resource.action]
            end

            if action.include?(:create)
              Chef::Log.debug("Found couch_service[#{resource.name}] resource with action :create")
              @couch_service_resource = resource
              return @couch_service_resource
            end
          end
        end

        Chef::Log.debug("Unable to find a couch_service resource with the action :create")
        fail "No eligible couch_service found for couch_config[#{new_resource.name}]"
      end
    end
  end
end
