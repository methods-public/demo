if defined?(ChefSpec)
  def add_cloudinsight_agent_monitor(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cloudinsight_agent_monitor, :add, resource_name)
  end

  def remove_cloudinsight_agent_monitor(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:cloudinsight_agent_monitor, :remove, resource_name)
  end
end
