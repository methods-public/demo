yum_repository 'mono' do
  description 'Mono repository'
  baseurl node['mono3']['yum_repository']
  gpgkey node['mono3']['yum_repository_key']
end
