include_recipe 'chef-vault'

package 'expect'

users = chef_vault_item(node['nessus']['vault'],node['nessus']['vault_users_item']).dup
users.delete("id") # remove the id key/val

users.each_pair do |user,password|
  log "#{user} - #{password}"

  bash "nessus_add_user_#{user}" do
    user "root"
    code <<-EOF
      /usr/bin/expect -c 'spawn /opt/nessus/sbin/nessus-adduser
      expect "Login : "
      send "#{user}\r"

      expect "Login password : "
      send "#{password}\r"
      expect "Login password (again) : "
      send "#{password}\r"

      expect "Do you want"
      send "y\r"

      sleep 5
      send "\r"

      expect "Is that ok "
      send "y\r"

      expect eof'
    EOF
  end
end
