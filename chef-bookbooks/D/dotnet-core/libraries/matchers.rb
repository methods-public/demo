if defined?(ChefSpec)
  #############
  # nginx_site
  #############
  ChefSpec.define_matcher :dotnet_install

  def enable_nginx_site(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:dotnet_install, :install, resource_name)
  end
  
end
