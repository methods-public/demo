
class Chef
  class Provider
    class DrupalMake
      class Timestamped < Chef::Provider::DrupalMake
        def release_slug
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        end
      end
    end
  end
end