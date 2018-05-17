module ConjurHostIdentityChef
  module ConjurHelper
    extend self
    
    def config_file node
      node.conjur.configuration_file
    end
    
    def netrc_file
      require 'conjur/config'
      Conjur::Config[:netrc_path]
    end
    
    def config? node
      File.exists?(config_file node)
    end
    
    def configure! node
      require 'conjur/api'
      require 'conjur/config'
      require 'conjur/authn'
      
      Conjur::Config.load [ config_file(node) ]
      Conjur::Config.apply
    end
    
    # Updates the Conjur configuration. Yields the existing config (which may be an
    # empty hash), then writes the config to the proper location.
    def update_config node, &block
      c = if config?(node)
        config(node)
      else
        {}
      end
      yield c
      File.write(config_file(node), YAML.dump(c))
    end
    
    def config node
      YAML.load(File.read(config_file(node)))
    end
    
    def save_credentials credentials
      require 'conjur/authn'
      netrc = Conjur::Authn.netrc
      netrc[Conjur::Authn.host] = credentials
      netrc.save
    end
    
    def credentials?
      require 'conjur/authn'
      Conjur::Authn.get_credentials noask: true
      true
    rescue
      false
    end
  end
end

class Chef::Recipe
  include ConjurHostIdentityChef
end