if defined?(ChefSpec)
  def create_chef_user(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_user, :create, name)
  end

  def delete_chef_user(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_user, :delete, name)
  end

  def create_chef_role(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_role, :create, name)
  end

  def delete_chef_role(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_role, :delete, name)
  end

  def create_chef_node(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_node, :create, name)
  end

  def delete_chef_node(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_node, :delete, name)
  end

  def create_chef_group(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_group, :create, name)
  end

  def delete_chef_group(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_group, :delete, name)
  end

  def create_chef_organization(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_organization, :create, name)
  end

  def delete_chef_organization(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_organization, :delete, name)
  end

  def create_chef_environment(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_environment, :create, name)
  end

  def delete_chef_environment(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_environment, :delete, name)
  end

  def create_chef_data_bag(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_data_bag, :create, name)
  end

  def delete_chef_data_bag(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_data_bag, :delete, name)
  end

  def create_chef_data_bag_item(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_data_bag_item, :create, name)
  end

  def delete_chef_data_bag_item(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_data_bag_item, :delete, name)
  end

  def create_chef_container(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_container, :create, name)
  end

  def delete_chef_container(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_container, :delete, name)
  end

  def create_chef_client(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_client, :create, name)
  end

  def delete_chef_client(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_client, :delete, name)
  end

  def create_chef_acl(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_acl, :create, name)
  end

  def delete_chef_acl(name)
    ChefSpec::Matchers::ResourceMatcher.new(:chef_acl, :delete, name)
  end

  def create_private_key(name)
    ChefSpec::Matchers::ResourceMatcher.new(:private_key, :create, name)
  end

  def delete_private_key(name)
    ChefSpec::Matchers::ResourceMatcher.new(:private_key, :delete, name)
  end

  def regenerate_private_key(name)
    ChefSpec::Matchers::ResourceMatcher.new(:private_key, :regenerate, name)
  end

  def create_public_key(name)
    ChefSpec::Matchers::ResourceMatcher.new(:public_key, :create, name)
  end

  def delete_public_key(name)
    ChefSpec::Matchers::ResourceMatcher.new(:public_key, :delete, name)
  end
end
