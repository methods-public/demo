wkhtmltopdf_version = Chef::Version.new(node['wkhtmltopdf']['version'])

file "#{node['wkhtmltopdf']['install_dir']}/wkhtmltoimage" do
  action :delete
end

file "#{node['wkhtmltopdf']['install_dir']}/wkhtmltopdf" do
  action :delete
end

unless node['wkhtmltopdf']['lib_dir'].empty?
  file "#{node['wkhtmltopdf']['lib_dir']}/libwkhtmltox.so.#{node['wkhtmltopdf']['version']}" do
    action :delete
  end

  link "#{node['wkhtmltopdf']['lib_dir']}/libwkhtmltox.so.#{wkhtmltopdf_version.major}.#{wkhtmltopdf_version.minor}" do
    action :delete
    only_if "test -L #{node['wkhtmltopdf']['lib_dir']}/libwkhtmltox.so.#{wkhtmltopdf_version.major}.#{wkhtmltopdf_version.minor}"
  end

  link "#{node['wkhtmltopdf']['lib_dir']}/libwkhtmltox.so.#{wkhtmltopdf_version.major}" do
    action :delete
    only_if "test -L #{node['wkhtmltopdf']['lib_dir']}/libwkhtmltox.so.#{wkhtmltopdf_version.major}"
  end
end
