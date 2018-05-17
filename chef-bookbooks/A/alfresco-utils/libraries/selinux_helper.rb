module SELinuxHelper
  def enforcing?
    Chef::Mixin::ShellOut.shell_out('getenforce | grep -i enforcing').exitstatus == 0
  end

  def semanage_installed?
    Chef::Mixin::ShellOut.shell_out('which semanage').exitstatus == 0
  end
end

Chef::Recipe.send(:include, SELinuxHelper)
Chef::Resource.send(:include, SELinuxHelper)
