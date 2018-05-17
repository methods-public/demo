#
# Author:: Barclay Loftus (<barclay@deliv.co>)
# Cookbook:: looker
# Recipe:: ssl
#

include_recipe 'aws'

# the keystore also requires java be present...
#
include_recipe 'java' unless File.exist?('/usr/bin/java')

# ensure we have the looker user
#
unless node['etc']['passwd'][node['looker']['looker_user']]
  include_recipe 'looker::user'
end

directory node['looker']['looker_dir'] do
  owner node['looker']['looker_user']
  group node['looker']['looker_group']
  mode '0755'
  action :create
end

# Setup the SSL
#
ssl_directory = File.join(node['looker']['looker_dir'], '.ssl')
directory ssl_directory do
  owner node['looker']['looker_user']
  group node['looker']['looker_group']
  mode '0755'
  action :create
end

# generate the keystore password file
#
keystorepass = File.join(ssl_directory, '.keystorepass')
if File.exist?(keystorepass)
  file keystorepass do
    action :delete
  end
end

execute 'Setup the java keystore password' do
  cwd ssl_directory
  sensitive true
  command "echo \"#{node['looker']['ssl']['keystore_password']}\" > #{keystorepass}"
  user node['looker']['looker_user']
end

aws_s3_file File.join(ssl_directory, 'certificate.key') do
  bucket node['looker']['ssl']['s3_bucket']
  remote_path node['looker']['ssl']['certificate_key_path']
  aws_access_key_id node['looker']['ssl']['aws_access_key_id']
  aws_secret_access_key node['looker']['ssl']['aws_secret_access_key']
end

aws_s3_file File.join(ssl_directory, 'certificate.pem') do
  bucket node['looker']['ssl']['s3_bucket']
  remote_path node['looker']['ssl']['certificate_path']
  aws_access_key_id node['looker']['ssl']['aws_access_key_id']
  aws_secret_access_key node['looker']['ssl']['aws_secret_access_key']
end

# generate the java keystore
#
jks_file = File.join(ssl_directory, 'looker.jks')
if File.exist?(jks_file)
  file jks_file do
    action :delete
  end
end

bash 'Generate the java key store' do
  user node['looker']['looker_user']
  cwd ssl_directory
  code <<-EOH
    openssl pkcs12 \
      -inkey certificate.key \
      -in certificate.pem \
      -export \
      -password pass:#{node['looker']['ssl']['keystore_password']} \
      -out keys.pkcs12

    keytool \
      -importkeystore \
      -srckeystore keys.pkcs12 \
      -srcstoretype pkcs12 \
      -srcstorepass #{node['looker']['ssl']['keystore_password']} \
      -deststorepass #{node['looker']['ssl']['keystore_password']} \
      -destkeystore #{jks_file}
  EOH
end

# cleanup
#
file File.join(ssl_directory, 'certificate.key') do
  action :delete
end
file File.join(ssl_directory, 'certificate.pem') do
  action :delete
end
