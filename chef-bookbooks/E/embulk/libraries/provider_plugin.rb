# Chef Provider for installing an Embulk plugin
class EmbulkCookbook::PluginProvider < Chef::Provider::LWRPBase
  include EmbulkCookbook::Helpers
  include Chef::Mixin::ShellOut

  provides :embulk_plugin

  def whyrun_supported?
    true
  end

  action :install do
    Chef::Log.debug "Installing embulk gem #{new_resource.name}"
    execute "#{Dir.home(new_resource.user)}/.embulk/bin/embulk gem install \
      #{new_resource.name} #{'--version' unless new_resource.version.nil?}\
      #{new_resource.version unless new_resource.version.nil?}" do
      user new_resource.user
      environment(
        'HOME' => Dir.home(new_resource.user),
        'USER' => new_resource.user
      )
      cwd Dir.home(new_resource.user)
      not_if { Dir.exist?("#{Dir.home(new_resource.user)}/.embulk/jruby/2.3.0/gems/#{new_resource.name}-#{new_resource.version unless new_resource.version.nil?}") }
    end
    new_resource.updated_by_last_action(true)
  end

  action :uninstall do
    Chef::Log.debug "Uninstalling embulk gem #{new_resource.name}"
    execute "#{Dir.home(new_resource.user)}/.embulk/bin/embulk gem uninstall #{'-a' if new_resource.version.nil?} \
      #{new_resource.name} #{'--version' unless new_resource.version.nil?} \
      #{new_resource.version unless new_resource.version.nil?}" do
      user new_resource.user
      cwd Dir.home(new_resource.user)
      environment(
        'HOME' => Dir.home(new_resource.user),
        'USER' => new_resource.user
      )
    end
    new_resource.updated_by_last_action(true)
  end
end
