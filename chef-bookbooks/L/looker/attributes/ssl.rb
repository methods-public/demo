#
# Author:: Barclay Loftus (<barclay@deliv.co>)
# Cookbook:: looker
# Attributes:: ssl
#

# if you'd like to have looker use a custom SSL certificate you'll
# want to populate these values
#
default['looker']['ssl']['aws_access_key_id']       = nil
default['looker']['ssl']['aws_secret_access_key']   = nil
default['looker']['ssl']['s3_bucket']               = nil
default['looker']['ssl']['certificate_key_path']    = nil
default['looker']['ssl']['certificate_path']        = nil

default['looker']['ssl']['keystore_password']       = Array.new(10)
                                                           .map { rand(10) }
                                                           .join

if node['looker']['use_custom_ssl']
  ssl_dir = File.join(node['looker']['looker_dir'], '.ssl')
  args = " --ssl-keystore=#{File.join(ssl_dir, 'looker.jks')} "\
         " --ssl-keystore-pass-file=#{File.join(ssl_dir, '.keystorepass')} "

  default['looker']['jar_start_args'] = args
end
