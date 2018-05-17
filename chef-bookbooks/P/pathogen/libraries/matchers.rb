if defined?(ChefSpec)
  def install_pathogen_plugin(plugin)
    ChefSpec::Matchers::ResourceMatcher.new(:pathogen_plugin, :install, plugin)
  end
end
