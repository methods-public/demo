default['windows_logrotate']['version'] = '0.0.0.18_20170228'
default['windows_logrotate']['sha256'] = '186bf4470b97a649997457992c2f80192a923503edaf144367391d3054c2ab73'
default['windows_logrotate']['install_dir'] = "#{ENV['SYSTEMDRIVE']}\\logrotate"
default['windows_logrotate']['zip_filename'] = "logrotateSetup_#{node['windows_logrotate']['version']}.zip"
default['windows_logrotate']['url'] = 'http://pilotfiber.dl.sourceforge.net/project' \
    "/logrotatewin/#{node['windows_logrotate']['zip_filename']}"
