resource_name :crenv_install
property :version, String, name_property: true
property :git_url, String, default: node['crenv']['git_url']
property :git_ref, String, default: node['crenv']['git_ref']
property :build_repo, String, default: node['crenv']['build_repo']
property :update_repo, String, default: node['crenv']['update_repo']
property :update, [NilClass, TrueClass, FalseClass], default: node['crenv']['upgrade']
property :crenv_users, [String,NilClass], default: node['crenv']['user_installs']
property :install_path, String, default: node['crenv']['install_path']
property :crystal_version, [Array, NilClass], default: node['crenv']['crystal-version']
property :plugins, [Hash,NilClass], default: node['crenv']['plugins']
property :user_plugin, [Hash, Array, NilClass], default: node['crenv']['user_plugins']

default_action :install

# installs one or more crenv versions
action :install do
    # we need to be able to both pull and compile crystal source code
    include_recipe 'build-essential::default'
    include_recipe 'git::default'

    # pull crenv from git
    git "#{install_path}/#{crenv_users}/.crenv" do
      repository git_url
      revision   git_ref
      user       crenv_users
      action     :checkout
    end

    #create directory for plugins
    directory "#{install_path}/#{crenv_users}/.crenv/plugins/" do
      owner crenv_users
      recursive true
    end

    #add default plugins
    git "#{install_path}/#{crenv_users}/.crenv/plugins/crystal-build" do
      repository build_repo
      user       crenv_users
      action     :checkout
    end

    git "#{install_path}/#{crenv_users}/.crenv/plugins/crystal-update" do
      repository update_repo
      user       crenv_users
      action     :checkout
    end

    unless ::File.exists?("#{install_path}/#{crenv_users}/.bashrc")
      template '/home/crenv/.bashrc' do
        source 'crenv.sh.erb'
        cookbook 'crenv'
        owner crenv_users
        action :create
      end
    else
      crenv_vars <<-EOH
      "PATH="$HOME/.crenv/bin:$PATH"
      eval "$(crenv init -)"
      EOH
      bashrc = File.read("#{install_path}/#{crenv_users}/.bashrc", 'r')

      unless bashrc.includes?(crenv_script)
        File.open("#{install_path}/#{crenv_users}/.bashrc", 'a') { |f| f.write(crenv_script) }
        File.open("#{install_path}/#{crenv_users}/.bash_profile", 'a') { |f| f.write(crenv_script) }
      end
    end

    crystal_version.each do |version|
      bash 'install version(s) of Crystal Language' do
        code <<-EOH
        source .bashrc
        crenv install #{version}
        crenv rehash
        EOH
        cwd "#{install_path}/#{crenv_users}"
        environment ({ "HOME" => "#{install_path}/#{crenv_users}"})
        user crenv_users
      end
    end
end

# removes one version
action :remove do
end

# similar to rvm implode command, removes crenv completely from the vm
action :destroy do
end
