require "mysql"



action :set do
  table = "#{node['wordpress']['database']['prefix']}options"
  ruby_block "set #{new_resource.name} to #{new_resource.value} on #{node['azure']['mysql']['server']}" do
    block do
      begin
        con = ::Mysql.new(
          node[:azure][:mysql][:server],
          node[:azure][:mysql][:username],
          node[:azure][:mysql][:password],
          node[:azure][:mysql][:databasename])
        puts con.get_server_info
        rs = con.query "INSERT INTO #{table} (option_name, option_value, autoload) VALUES('#{new_resource.name}', '#{new_resource.value}', '#{new_resource.autoload}')"
        #rs.fetch_row    
      rescue ::Mysql::Error => e
        puts e.errno
        puts e.error
      ensure
        con.close if con
      end
    end
    not_if do
      begin
        success = nil
        con = ::Mysql.new(
          node[:azure][:mysql][:server],
          node[:azure][:mysql][:username],
          node[:azure][:mysql][:password],
          node[:azure][:mysql][:databasename])
        puts con.get_server_info
        rs = con.query "select * from #{table} where option_name='#{new_resource.name}' and option_value='#{new_resource.value}'"
        success = rs.fetch_row
      rescue ::Mysql::Error => e
        error = e
        puts e.errno
        puts e.error
      ensure
        con.close if con
        success
      end
    end
  end
end
