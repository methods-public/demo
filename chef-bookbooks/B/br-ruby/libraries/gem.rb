#
# Cookbook Name:: br-ruby
# Library:: gem
#

module BR
  module Ruby
    class Gem

      attr_reader :name, :version, :runtime

      def initialize(name, version, runtime)
        raise ArgumentError, 'name cannot be nil' unless name
        raise ArgumentError, 'version cannot be nil' unless version
        raise ArgumentError, 'runtime cannot be nil' unless runtime

        @name = name
        @version = version
        @runtime = runtime
      end

      def executable
        ::File.join(runtime.bin_path, 'gem')
      end

      def install_command
        "#{executable} install #{name} --version=\"#{version}\""
      end

    end
  end
end
