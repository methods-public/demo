#
# Cookbook Name:: resource-weight
# Recipe:: default
#
# Copyright (c) 2016 Criteo

Chef.event_handler do
  on :converge_start do |run_context|
    run_context.node['resource-weight'].each do |resource_class_name, options|
      name       = Chef::Mixin::ConvertToClassName.convert_to_class_name(resource_class_name)
      klass      = Chef::Resource.const_get(name)

      run_context.resource_collection.select do |resource|
        resource.is_a?(klass)
      end.each do |resource|
        if !klass.properties[:weight].is_set?(resource) && options['default-weight']
          Chef::Log.debug "Will modify #{resource}'s weight to #{options['default-weight']}"
          resource.weight = options['default-weight']
        end
      end
    end
  end
end
