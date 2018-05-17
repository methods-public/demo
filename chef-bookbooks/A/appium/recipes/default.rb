# install appium
case node['platform_family']
when 'rhel', 'debian'
  include_recipe 'nodejs'

  nodejs_npm 'appium' do
    path "#{node['appium']['nodejs_home']}/bin" unless node['appium']['nodejs_home'].nil?
    options node['appium']['npm_options']
    version node['appium']['version']
    user node['appium']['user']
  end
else
  log('Appium cannot be installed on this platform using this cookbook.') { level :warn }
end
