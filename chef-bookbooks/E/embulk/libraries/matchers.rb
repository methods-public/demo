# ChefSpec is a tool to unit test cookbooks in conjunction with rspec
# Learn more on the README or at https://github.com/sethvargo/chefspec.

if defined?(ChefSpec)
  ChefSpec.define_matcher(:embulk_plugin)

  def install_embulk_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:embulk_plugin, :install, resource_name)
  end

  def uninstall_embulk_plugin(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:embulk_plugin, :uninstall, resource_name)
  end
end
