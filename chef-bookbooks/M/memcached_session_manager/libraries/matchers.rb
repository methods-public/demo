if defined?(ChefSpec)
  def install_memcached_session_manager_context(name)
    ChefSpec::Matchers::ResourceMatcher.new(:memcached_session_manager_context, :install, name)
  end

  def remove_memcached_session_manager_context(name)
    ChefSpec::Matchers::ResourceMatcher.new(:memcached_session_manager_context, :remove, name)
  end
end
