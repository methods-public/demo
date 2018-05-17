
class Chef
  class Provider
    class DrupalMake
      class Dev < Chef::Provider::DrupalMake
        def release_slug
          'dev'
        end
      end
    end
  end
end