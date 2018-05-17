#
# Cookbook Name:: br-ruby
# Library:: runtime
#

require 'pathname'

module BR
  module Ruby
    class Runtime

      attr_reader :version, :install_path

      def self.installed_at(path)
        directories = Dir.glob(::File.join(path, "*#{::File::Separator}"))
        paths = directories.map { |directory| Pathname.new(directory) }
        versions = paths.map { |path| [path.basename.to_s, path.dirname.to_s] }
        versions.map { |version, path| new(version, path) }
      end

      def initialize(version, install_path)
        raise ArgumentError, 'version cannot be nil' unless version
        raise ArgumentError, 'install_path cannot be nil' unless install_path

        @version = version
        @install_path = install_path
      end

      def root
        ::File.join(install_path, version)
      end

      def bin_path
        ::File.join(root, 'bin')
      end

      def executable
        ::File.join(bin_path, 'ruby')
      end

      def installed?
        ::File.exist?(executable)
      end

      def exist?
        ::File.exist?(root)
      end

    end
  end
end
