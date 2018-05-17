#
# Cookbook Name:: br-rails
# Library:: recipe
#

module BR
  module Rails
    module Recipe

      include Chef::Mixin::DeepMerge

      def applications
        @applications ||= build_applications
      end

      def build_applications
        hash = {}

        node['rails']['applications'].each do |key, value|
          hash[key] = deep_merge(node['rails']['default'].to_hash, value.to_hash)
          hash[key]['root'] = ::File.join(hash[key]['install_path'], key.to_s)
        end

        hash
      end

    end
  end
end
