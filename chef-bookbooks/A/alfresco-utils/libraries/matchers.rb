if defined?(ChefSpec)
  ChefSpec.define_matcher :maven_setup
  ChefSpec.define_matcher :artifact
  ChefSpec.define_matcher :change_own_mod
  ChefSpec.define_matcher :transient_variable
  ChefSpec.define_matcher :file_rename

  def create_maven_setup(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:maven_setup, :create, resource_name)
  end

  def create_artifact(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:artifact, :create, resource_name)
  end

  def run_change_own_mod(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:change_own_mod, :run, resource_name)
  end

  def create_transient_variable(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:transient_variable, :create, resource_name)
  end

  def create_file_rename(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:file_rename, :create, resource_name)
  end

end
