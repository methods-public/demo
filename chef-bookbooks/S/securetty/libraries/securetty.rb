#
# Cookbook: securetty
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

require 'poise'

module SecurettyCookbook
  module Resource
    # Resource for managing the Securetty Configuration file.
    class Securetty < Chef::Resource
      include Poise(fused: true)
      provides(:securetty)

      default_action(:create)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:cookbook, kind_of: String, default: 'securetty')
      attribute(:ttys, kind_of: [Array, NilClass], default: nil)

      action(:create) do
        notifying_block do
          # Write out securetty config file
          unless new_resource.ttys.nil? || new_resource.ttys.empty?
            template new_resource.path do
              source 'securetty.erb'
              cookbook new_resource.cookbook
              mode 0644
              owner 'root'
              group 'root'
            end
          end
        end
      end
    end
  end
end
