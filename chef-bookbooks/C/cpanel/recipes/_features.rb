# Recipe to control features from.

# This recipe will create the feature files needed, but will not refresh clients (yet!)


node['cpanel']['features'].keys.each do |ftr|
  feature = node['cpanel']['features'][ftr]
    ftr_action = if feature['enabled']
                   "create"
                 else
                   'delete'
                 end
    template "/var/cpanel/features/#{ftr}" do
      source 'packages.erb'
      variables params: feature['params']
      mode '0644'
      action ftr_action
    end
end
                       
