#
# Cookbook: blp-updatedb
# License: Apache 2.0
#
# Copyright 2015-2017, Bloomberg Finance L.P.
#

provides :updatedb
provides :updatedb_config

property :path, String, name_property: true
property :settings, Hash, default: {}

def content
  settings.merge({}) do |_kv, n|
    if n.is_a?(Array)
      n.flatten.map(&:to_s).join(',')
    else
      n
    end
  end.map { |k, v| k.upcase << "=\"#{v}\"" }.join("\n")
end

action :create do
  file new_resource.path do
    content new_resource.content
  end
end
