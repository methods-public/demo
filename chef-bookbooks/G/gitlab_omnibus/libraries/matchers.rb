if defined?(ChefSpec)
  ChefSpec.define_matcher :gitlab_omnibus_service

  # gitlab_omnibus_service resource matchers
  def reconfigure_gitlab_omnibus_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gitlab_omnibus_service, :reconfigure, resource_name)
  end

  def start_gitlab_omnibus_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gitlab_omnibus_service, :start, resource_name)
  end

  def stop_gitlab_omnibus_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gitlab_omnibus_service, :stop, resource_name)
  end

  def restart_gitlab_omnibus_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gitlab_omnibus_service, :restart, resource_name)
  end
end
