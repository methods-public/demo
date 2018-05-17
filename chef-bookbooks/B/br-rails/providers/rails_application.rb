#
# Cookbook Name:: br-rails
# Provider:: rails_application
#

provides :rails_application

use_inline_resources

def whyrun_supported?
  true
end

def application
  @application ||= BR::Rails::Application.new(new_resource.root,
    environment: new_resource.environment,
    ruby: new_resource.ruby,
    config: new_resource.config,
    commands: new_resource.commands)
end

action :configure do
  application.configure! do |application|
    application.config_files.each do |config_file|
      directory config_file.directory do
        owner config_file.owner
        group config_file.group
        mode config_file.mode
        recursive true
      end

      data = { data: config_file.data }

      template config_file.path do
        cookbook config_file.cookbook
        source config_file.template
        owner config_file.owner
        group config_file.group
        mode config_file.mode
        sensitive config_file.sensitive?
        variables data
      end
    end
  end
end

action :install do
  application.install! do |application|
    application.commands.each do |command|
      execute command.name do
        command command.to_s
        cwd command.directory
        environment command.environment
        sensitive command.sensitive?

        action :run
      end
    end
  end
end

action :migrate do
  application.migrate! do |application|
    application.commands.each do |command|
      execute command.name do
        command command.to_s
        cwd command.directory
        environment command.environment
        sensitive command.sensitive?

        action :run
      end
    end
  end
end
