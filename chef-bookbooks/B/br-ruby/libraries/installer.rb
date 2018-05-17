#
# Cookbook Name:: br-ruby
# Library:: installer
#

module BR
  module Ruby
    module Installer

      def self.resource_class_for(name)
        Chef::Resource.resource_matching_short_name(name.to_sym)
      end

      def self.resource_for(name, attributes)
        resource_class_for(name).new(attributes['version'], attributes)
      end

      def self.provider_class_for(node, resource, action)
        Chef::ProviderResolver.new(node, resource, action).resolve
      end

      def self.provider_for(new_resource, run_context)
        resource_attributes = new_resource.to_hash.inject({}){ |h, (k,v)| h.merge({ k.to_s => v}) }
        installer_attributes = new_resource.installer['attributes'].merge(resource_attributes)
        resource = resource_for(new_resource.installer['name'], installer_attributes)
        provider_class_for(run_context.node, resource, new_resource.action).new(resource, run_context)
      end

    end
  end
end
