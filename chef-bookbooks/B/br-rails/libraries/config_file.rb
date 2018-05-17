#
# Cookbook Name:: br-rails
# Library:: config_file
#

module BR
  module Rails
    class ConfigFile

      attr_reader :application, :attributes, :data

      def self.build(application, config_files)
        config_files.map do |name, attributes|
          ConfigFile.new(application, attributes)
        end
      end

      def initialize(application, attributes = {})
        @application = application
        @attributes = attributes
        @data = ConfigData.new(attributes.fetch('values', {}).to_hash)
      end

      def root
        ::File.join(application.root, 'config')
      end

      def owner
        attributes.fetch('owner', application.owner)
      end

      def group
        attributes.fetch('group', application.group)
      end

      def mode
        attributes.fetch('mode', application.mode)
      end

      def directory
        ::File.join(root, attributes.fetch('directory', '/'))
      end

      def filename
        String(attributes['filename'])
      end

      def path
        ::File.join(directory, filename)
      end

      def cookbook
        attributes.fetch('cookbook', 'br-rails')
      end

      def template
        attributes.fetch('template', 'default.yml.erb')
      end

      def sensitive?
        String(attributes['sensitive']).downcase == 'true'
      end

    end
  end
end
