if defined?(ChefSpec)
  ChefSpec.define_matcher(:ruby_source)
  def install_ruby_source(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:ruby_source, :install, resource)
  end

  def uninstall_ruby_source(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:ruby_source, :uninstall, resource)
  end

  ChefSpec.define_matcher(:ruby_ree)
  def install_ruby_ree(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:ruby_ree, :install, resource)
  end

  def uninstall_ruby_ree(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:ruby_ree, :uninstall, resource)
  end
end
