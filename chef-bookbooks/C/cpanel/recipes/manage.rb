# Manage packages, features and other services
node['cpanel']['manage_features'].keys.each do |v|
  include_recipe "cpanel::_#{v}" if node['cpanel']['manage_features'][v]
end
