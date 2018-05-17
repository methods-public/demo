#
# Cookbook Name:: br-rails
# Library:: config_data
#

module BR
  module Rails
    class ConfigData < SimpleDelegator

      def with_flat_keys
        flatten_keys(data)
      end

      private

      def data
        __getobj__
      end

      def flatten_keys(object, keys = [], parent = {})
        return parent.update({ keys => object }) unless object.is_a? Hash
        object.each { |key, value| flatten_keys(value, keys + [key], parent) }
        parent
      end

    end
  end
end
