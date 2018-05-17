#
# Cookbook: sysconfig
# License: Apache 2.0
#
# Copyright 2016, Bloomberg Finance L.P.
#

require 'poise'

module SysconfigCookbook
  module Resource
    # Resource for managing sysconfig.
    class Sysconfig < Chef::Resource
      include Poise(fused: true)
      provides(:sysconfig)

      attribute(:service_name, kind_of: String, name_attribute: true)
      attribute(:settings, option_collector: true, default: {})

      def to_s
        s = settings.merge({}) do |_k, _o, n|
          if n.is_a?(Array)
            n.flatten.map(&:to_s).join(',')
          else
            n
          end
        end
        s.map { |k,v|
          if v.match(/[\W\s]+/) then
            g = "=\"#{v}\""
          else
            g = "=#{v}"
          end
           k.upcase << g}.join("\n")
      end

      action(:create) do
        notifying_block do
          # Write out sysconfig config file
          unless new_resource.to_s.empty?
            file "/etc/sysconfig/#{new_resource.service_name}" do
              content new_resource.to_s
            end
          end
        end
      end
    end
  end
end
