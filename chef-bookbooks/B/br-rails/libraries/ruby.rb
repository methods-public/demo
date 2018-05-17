#
# Cookbook Name:: br-rails
# Library:: ruby_version
#

module BR
  module Rails
    class Ruby

      attr_reader :install_path, :version

      def initialize(attributes)
        @install_path = attributes['install_path']
        @version = attributes['version']
      end

      def root
        ::File.join(install_path, version)
      end

      def bin_path
        ::File.join(root, 'bin')
      end

    end
  end
end
