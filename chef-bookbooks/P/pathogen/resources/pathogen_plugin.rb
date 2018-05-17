resource_name :pathogen_plugin

property :name, String, required: true, name_property: true
property :github_org, String, required: true
property :users, Array, required: true

default_action :install

action :install do
  users.each do |user|
    home = Dir.home(user)

    git name do
      repository "https://github.com/#{github_org}/#{name}.git"
      revision   'master'
      destination ::File.join(home, '.vim/bundle', name)
    end
  end
end
