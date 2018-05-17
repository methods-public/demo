# For ChefSpec LWRP custom matchers:
# https://github.com/sethvargo/chefspec#packaging-custom-matchers
if defined?(ChefSpec)
  def create_collectd_ii_plugin(name)
    ChefSpec::Matchers::ResourceMatcher.new(:collectd_ii_plugin, :create, name)
  end

  def delete_collectd_ii_plugin(name)
    ChefSpec::Matchers::ResourceMatcher.new(:collectd_ii_plugin, :delete, name)
  end

  def create_collectd_python_plugin(name)
    ChefSpec::Matchers::ResourceMatcher.new(:collectd_ii_plugin, :create, name)
  end

  def delete_collectd_python_plugin(name)
    ChefSpec::Matchers::ResourceMatcher.new(:collectd_ii_plugin, :delete, name)
  end
end
