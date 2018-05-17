if defined?(ChefSpec)
  def add_oneapm_ci_agent_monitor(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:oneapm_ci_agent_monitor, :add, resource_name)
  end

  def remove_oneapm_ci_agent_monitor(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:oneapm_ci_agent_monitor, :remove, resource_name)
  end
end
