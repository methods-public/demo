#
# Cookbook Name:: br-rails
# Library:: rails_application
#

module BR
  module Rails
    class Application

      attr_reader :root, :ruby, :environment, :config, :config_files, :commands

      def initialize(root, ruby: {}, environment: {}, config: {}, commands: {})
        @root = root
        @ruby = Ruby.new(ruby)
        @environment = environment
        @config = config
        @config_files = ConfigFile.build(self, config)
        @commands = Command.build(self, commands)
      end

      def configure!
        yield self
      end

      def install!
        yield self
      end

      def migrate!
        yield self
      end

      def environment
        environment = @environment.dup
        environment['PATH'] = "#{ruby.bin_path}:#{ENV['PATH']}"
        environment
      end

      def owner
        config['owner']
      end

      def group
        config['group']
      end

      def mode
        config['mode']
      end

    end
  end
end
