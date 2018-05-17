#
# Author:: Barclay Loftus (<barclay@deliv.co>)
# Cookbook:: looker
# Recipe:: nginx
#
include_recipe 'aws'

# Setup the SSL
#
ssl_directory = node['looker']['nginx']['ssl_directory']
directory ssl_directory do
  owner 'root'
  group 'www-data'
  mode '0755'
  action :create
  recursive true
end

# download the certificate and the key
#
certificate = File.join(ssl_directory, 'certificate.pem')
aws_s3_file certificate do
  bucket node['looker']['ssl']['s3_bucket']
  remote_path node['looker']['ssl']['certificate_key_path']
  aws_access_key_id node['looker']['ssl']['aws_access_key_id']
  aws_secret_access_key node['looker']['ssl']['aws_secret_access_key']
end

key = File.join(ssl_directory, 'certificate.key')
aws_s3_file key do
  bucket node['looker']['ssl']['s3_bucket']
  remote_path node['looker']['ssl']['certificate_path']
  aws_access_key_id node['looker']['ssl']['aws_access_key_id']
  aws_secret_access_key node['looker']['ssl']['aws_secret_access_key']
end

include_recipe 'nginx'

# use our custom nginx.conf, rather than the one that ships in the nginx
# cookbook this avoids the nginx and my-app cookbooks from fighting for
# control of the same target file
#
f = resources('template[nginx.conf]')
f.variables(
  looker_domain: node['looker']['nginx']['looker_domain_name'],
  certificate_path: certificate,
  certificate_key_path: key
)
f.cookbook('looker')
