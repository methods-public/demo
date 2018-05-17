node['collectd_ii']['packages'].each do |pkg|
  package pkg
end

include_recipe 'collectd_ii::_service' do
  only_if { node['collectd_ii']['packages'].include?('collectd') }
end
