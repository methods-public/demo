#
# Cookbook: hosts_allow
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

require 'poise'

module HostsallowCookbook
  module Resource
    # Resource for managing the hosts.allow file.
    class Hostsallow < Chef::Resource
      include Poise(fused: true)
      provides(:hosts_allow)

      attribute(:path, kind_of: String, name_attribute: true)
      attribute(:cookbook, kind_of: String, default: 'hosts_allow')
      attribute(:settings, option_collector: true, default: nil)

      action(:create) do
        notifying_block do
          # Write out hosts.allow
          unless new_resource.settings.nil? || new_resource.settings.empty?
            template new_resource.path do
              source 'hosts.allow.erb'
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
