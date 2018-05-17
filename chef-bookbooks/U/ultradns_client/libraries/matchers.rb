if defined?(ChefSpec)
  def ultradns_client_create(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(resource, action, resource_name)
  end
  def ultradns_client_update(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(resource, action, resource_name)
  end
  def ultradns_client_delete(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(resource, action, resource_name)
  end
end