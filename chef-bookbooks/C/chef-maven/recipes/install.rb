tar_extract node['maven']['url'] do
  download_dir Chef::Config['file_cache_path']
  target_dir "/usr/local"
  creates "/usr/local/apache-maven-#{node['maven']['version']}"
end

link "/usr/bin/mvn" do
  to "#{node['maven']['m2_home']}/bin/mvn"
  link_type :symbolic
end

directory '/root/.m2' do
  owner node['maven']['user']
  group node['maven']['group']
  mode node['maven']['dir_perm']
end

cookbook_file '/root/.m2/settings.xml' do
  source node['maven']['settings_file']
  owner node['maven']['user']
  group node['maven']['group']
  mode '0644'
end

template '/etc/profile.d/mvn.sh' do
  source 'maven.erb'
  cookbook node['maven']['template_cookbook']
  mode node['maven']['dir_perm']
end
