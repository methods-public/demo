cache_dir = Chef::Config[:file_cache_path]
download_dest = File.join(cache_dir, node['wkhtmltopdf-update']['package'])

remote_file download_dest do
  source node['wkhtmltopdf-update']['mirror_url']
  mode '0644'
  action :create_if_missing
end

package 'wkhtmltopdf' do
  source download_dest
  not_if "/usr/local/bin/wkhtmltopdf --version | grep #{node['wkhtmltopdf-update']['version']}"

  # if source.end_with?('.deb')
  #   provider Chef::Provider::Package::Dpkg
  # elsif source.end_with?('.rpm')
  #   provider Chef::Provider::Package::Rpm
  # end
end
