if defined?(ChefSpec)
  ChefSpec.define_matcher :gliderlabs_registrator

  def configure_gliderlabs_registrator(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:gliderlabs_registrator, :create, resource_name)
  end
end
