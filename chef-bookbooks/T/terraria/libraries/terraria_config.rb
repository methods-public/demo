#
# Cookbook: terraria
# License: Apache 2.0
#
# Copyright 2016, John Bellone <jbellone@bloomberg.net>
#
require 'poise'

module TerrariaCookbook
  module Resource
    # A resource which manages Terraria server configuration.
    # @since 1.0
    class TerrariaConfig < Chef::Resource
      include Poise(fused: true)
      provides(:terraria_config)

      property(:path, kind_of: String, name_attribute: true)
      property(:owner, kind_of: String)
      property(:group, kind_of: String)
      property(:mode, kind_of: String, default: '0640')

      attribute(:options, option_collector: true, default: {})

      action(:create) do
        notifying_block do
          directory ::File.dirname(new_resource.path) do
            recursive true
            mode '0755'
          end

          rc_file new_resource.path do
            type 'json'
            options new_resource.options
            owner new_resource.owner
            group new_resource.group
            mode new_resource.mode
          end
        end
      end

      action(:delete) do
        rc_file new_resource.path do
          action :delete
        end
      end
    end
  end
end
