module VS2008
  module Prerequisites

    def is_vs2008_installed?()
      registry_key_exists?(node['vs-2008']['base-package-registry'])
    end

    def is_dotnet_installed?()
      #http://blogs.msdn.com/b/deva/archive/2008/12/10/how-to-determine-which-microsoft-net-framework-version-and-service-pack-installed.aspx
      registry_key_exists?(node['vs-2008']['dotnet_key_path'])      
    end
  
    def is_vs2008_sp1_installed?()
      registry_key_exists?(node['vs-2008']['sp1-package-registry'])
    end

    def is_vs2008_sp1_version_installed?()
      if (!is_vs2008_sp1_installed?())
        return false
      end

      registry_data_exists?(
        node['vs-2008']['sp1-package-registry'],
          { :name => node['vs-2008']['sp1-package-registry-name'], :type => :string, :data => node['vs-2008']['sp1-package-registry-value']}
      )     

    end
    def install_vs2008_sp1?()
      (node['vs-2008']['install-vs2008-sp1']).downcase.eql?('yes')
    end

  end

end
