if defined?(ChefSpec)
  def create_pertino_client(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:pertino_client, :create, resource_name)
  end

  def delete_pertino_client(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:pertino_client, :delete, resource_name)
  end
end
