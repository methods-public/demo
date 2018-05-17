#
# cookbook::unzip_fx
# recipe::kitchen
#
# author::fxinnovation
# description::Test recipe used for kitchen tests
#

unzip_fx 'consul' do
  source      node['unzip_fx']['source']
  checksum    node['unzip_fx']['checksum']
  target_dir  node['unzip_fx']['target_dir']
  creates     node['unzip_fx']['creates']
  user        node['unzip_fx']['user']       unless node['platform_family'] == 'windows'
  group       node['unzip_fx']['group']      unless node['platform_family'] == 'windows'
  mode        node['unzip_fx']['mode']       unless node['platform_family'] == 'windows'
  action      :extract
end
