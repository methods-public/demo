# frozen_string_literal: true
# ruby_rbenv doesn't seem to provide this matcher? Maybe I'm using the wrong one...
if defined?(ChefSpec)
  define_method('install_rbenv_user_install') do |name|
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_user_install, :install, name)
  end
end
