#
# Author:: Barclay Loftus (<barclay@deliv.co>)
# Cookbook:: looker
# Attributes:: nginx
#

# if you'd like to have looker use a custom SSL certificate you'll
# want to populate these values
#
default['looker']['nginx']['looker_domain_name']    = 'looker5.deliv.co'
default['looker']['nginx']['ssl_directory']         = File.join('/', 'etc', 'looker', 'ssl')

# TODO: reconcile if we want the java app running the certs, or nginx
default['looker']['ssl']['aws_access_key_id']       = nil
default['looker']['ssl']['aws_secret_access_key']   = nil
default['looker']['ssl']['s3_bucket']               = nil
default['looker']['ssl']['certificate_key_path']    = nil
default['looker']['ssl']['certificate_path']        = nil
