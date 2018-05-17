# Recipe to control packages from.

# This recipe will create the package files needed, but will not refresh clients (yet!)


node['cpanel']['packages'].keys.each do |pkg|
  package = node['cpanel']['packages'][pkg]

  package_ok = true
  missing_list = []
  %w(BWLIMIT CGI CPMOD DIGESTAUTH FEATURELIST HASSHELL IP LANG MAXADDON MAXFTP MAXLST MAXPARK MAXPOP MAXSQL MAXSUB MAX_DEFER_FAIL_PERCENTAGE MAX_EMAIL_PER_HOUR QUOTA).each do |pkg_param|
    unless package['params'].has_key?(pkg_param) 
       package_ok = false
       missing_list << pkg_param
    end
  end

  if package_ok 
    pkg_action = if package['enabled']
                   "create"
                 else
                   'delete'
                 end
      
    template "/var/cpanel/packages/#{pkg}" do
      source 'packages.erb'
      variables params: package['params']
      mode '0644'
      action pkg_action
    end
  else
    Chef::Log.warn("Package \"#{pkg}\" was not created because params \"#{missing_list.join(',')}\" are missing")
  end
end
                       
