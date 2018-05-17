apt_repository 'mono' do
  uri node['mono3']['apt_repository']
  keyserver node['mono3']['apt_keyserver']
  key node['mono3']['apt_repository_key']
  components ['main', 'stable']
  action :add
end
