execute 'Composer Install' do
  command 'curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer'
  action :run
  not_if { File.exist?('/usr/local/bin/composer') }
end

execute 'Composer Update' do
  command 'composer self-update'
  action :run
  not_if { node['composer']['key'] == false }
end

if node['composer']['key']['users']
  node['composer']['key']['users'].each do |user|
    link "/home/#{user}/composer" do
      to '/usr/local/bin/composer'
    end

    link "/home/#{user}/composer.phar" do
      to '/usr/local/bin/composer'
    end
  end
end

if node['composer']['key']['token'] && node['composer']['key']['users']
  node['composer']['key']['users'].each do |user|
    execute 'Add Deployment Key' do
      command "su #{user} -c 'composer config github-oauth.github.com --global \"#{node['composer']['key']['token']}\"'"
      action :run
      not_if { node['composer']['key']['token'].nil? }
    end
  end
end
