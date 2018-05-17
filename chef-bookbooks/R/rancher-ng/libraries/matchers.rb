if defined?(ChefSpec)
  ###############
  # rancher_ng_agent
  ###############
  ChefSpec.define_matcher :rancher_ng_server

  def create_server(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:rancher_ng_server, :create, resource_name)
  end

  ###############
  # rancher_ng_server
  ###############
  ChefSpec.define_matcher :rancher_ng_agent

  def create_agent(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:rancher_ng_agent, :create, resource_name)
  end
end
