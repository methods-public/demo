include_recipe 'git_user'

if node['users']
  node['users'].each do |username|
    user = data_bag_item(node['git_user']['data_bag_name'], username)

    next if user['git_user'].nil? || !user['git_user']['enabled']

    git_user user['id'] do
      home user['home']
      full_name user['git_user']['full_name']
      email user['git_user']['email']
      private_key user['git_user']['private_key']
      known_hosts user['git_user']['known_hosts']
    end
  end
end
