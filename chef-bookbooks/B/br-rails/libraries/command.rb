#
# Cookbook Name:: br-rails
# Library:: command
#

module BR
  module Rails
    class Command

      attr_reader :application, :attributes

      def self.build(application, commands)
        commands.map do |name, attributes|
          Command.new(application, attributes)
        end
      end

      def initialize(application, attributes = {})
        @application = application
        @attributes = attributes
      end

      def name
        attributes['command']
      end

      def directory
        application.root
      end

      def environment
        application.environment
      end

      def options
        attributes.fetch('options', [])
      end

      def sensitive?
        String(attributes['sensitive']).downcase == 'true'
      end

      def to_s
        return unless attributes['command']
        "#{attributes['command']} #{options.join(' ')}"
      end

    end
  end
end
