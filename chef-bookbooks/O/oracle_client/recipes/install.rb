execute 'powershell script' do
command "powershell.exe #{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}\\#{node['oracle_client']['client']}\\#{node['oracle_client']['setup']} #{node['oracle_client']['silent']} #{node['oracle_client']['force']} #{node['oracle_client']['waitforcompletion']} #{node['oracle_client']['noconsole']}  #{node['oracle_client']['responsefile']} #{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}\\#{node['oracle_client']['client']}\\#{node['oracle_client']['response_dir']}\\#{node['oracle_client']['response_file']}"
action :run
end

directory "#{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}" do
recursive true
action :delete
end

directory "#{node['oracle_client']['temp_dir']}\\#{node['oracle_client']['output_file']}#{node['oracle_client']['zip']}" do
recursive true
action :delete
end


