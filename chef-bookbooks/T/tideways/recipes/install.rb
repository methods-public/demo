include_recipe 'tideways::repository'

packages = ['tideways-php', 'tideways-cli', 'tideways-daemon']

packages.each do |package_name|
  package package_name do
    action :upgrade
  end
end

service 'tideways' do
  service_name 'tideways-daemon'
  supports start: true, stop: true
  action [:enable, :start]
end
