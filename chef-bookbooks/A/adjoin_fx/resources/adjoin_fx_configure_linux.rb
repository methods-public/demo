#
# cookbook::adjoin_fx
# resource::adjoin_fx_configure
#
# author::fxinnovation
# description::Allows you to configure realmd on linux machines
#

# Declaring resource name
resource_name :adjoin_fx_configure

# Declaring provider
provides :adjoin_fx_configure, os: 'linux'

# Declaring properties
property :login_groups, Array
property :login_users,  Array
property :deny_all,     [true, false]
property :domain,       String, required: true

# Declaring default action
default_action :configure

# Declaring configure action
action :configure do
  # Installing dependency to configure realmd on debian 9+ servers
  package 'packagekit' do
    action  :install
    only_if { node['platform_version'] > '9.0' && node['platform'] == 'debian' }
  end

  # Deny login from all groups if property is set for defined realm
  execute 'adjoin_fx_confgiure_deny_all' do
    command "realm deny -all --unattended --realm \"#{new_resource.domain}\""
    user    'root'
    action  :run
    only_if { new_resource.deny_all }
  end if property_is_set?(:deny_all)

  # Allow login from login groups if property is set
  # TODO: Add removal of any group which isn't passed on
  # For each login_groups
  new_resource.login_groups.each do |login_group|
    # Add the login group
    execute "adjoin_fx_configure_login_group_#{login_group}" do
      command "realm permit --realm \"#{new_resource.domain}\" --groups \"#{login_group.tr(' ', '_').downcase}\""
      user    'root'
      action  :run
      not_if  "echo \"$(realm list | grep -Pzo \"^#{new_resource.domain}(\\s{2}.*){1,}\")\" | grep \"permitted-groups:\" | grep \"#{login_group}\""
    end
  end if property_is_set?(:login_groups)

  # Allow login from login users if property is set
  # TODO: Add removal of any user which isn't passed on
  new_resource.login_users.each do |login_user|
    execute "adjoin_fx_configure_login_user_#{login_user}" do
      command "realm permit --realm \"#{new_resource.domain}\" \"#{login_user.tr(' ', '_').downcase}@#{new_resource.domain}\""
      user    'root'
      action  :run
      not_if  "echo \"$(realm list | grep -Pzo \"^#{new_resource.domain}(\\s{2}.*){1,}\")\" | grep \"permitted-logins:\" | grep \"#{login_user}\""
    end
  end if property_is_set?(:login_users)
end
