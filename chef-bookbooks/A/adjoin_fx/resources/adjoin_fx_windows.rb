#
# cookbook::adjoin_fx
# resource::adjoin_fx
#
# author::fxinnovation
# description::Custom resource for join a windows machine to an Active Directory
#

# Defining resource name
resource_name :adjoin_fx

# Declare provider
provides :adjoin_fx, platform_family: 'windows'

# Defining properties
property :target_ou,     String
property :server,        String
property :new_name,      String
property :username,      String,        required: true
property :domain,        String,        required: true
property :password,      String,        required: true, sensitive: true
property :handle_reboot, [true, false], default:  true
property :pass_thru,     [true, false], default:  false

# Defining default action
default_action :join

# Defining join action
action :join do
  # Defining a reboot resource
  reboot 'adjoin_fx_reboot' do
    reason     'Rebooting because of adjoin_fx_windows chef resource'
    delay_mins 1
    action     :nothing
  end

  # Initializing option string
  options_string = ''

  # Defining target_ou_string
  options_string << "-OUPath \"#{new_resource.target_ou}\" " if property_is_set?(:target_ou)

  # Defining server string
  options_string << "-Server \"#{new_resource.server}\" " if property_is_set?(:server)

  # Defining new_name string
  options_string << "-NewName \"#{new_resource.new_name}\" " if property_is_set?(:new_name)

  # Defining force option
  options_string << '-PassThru ' if new_resource.pass_thru == true

  # Joining to the domain
  # NOTE: Putting the password as an environment variable is safer because the env var won't be written to disk
  # (To the best of my knowledge)
  powershell_script "ad_join_#{new_resource.name}" do
    code <<-EOH
$username = '#{new_resource.domain}\\#{new_resource.username}'
$password = $Env:clear_password | ConvertTo-SecureString -asPLainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username,$password)
Add-Computer "#{new_resource.domain}" #{options_string} -Credential $credential -WarningAction SilentlyContinue -Force -ErrorAction Stop
    EOH
    not_if      "((gwmi win32_computersystem).domain -eq '#{new_resource.domain}')"
    notifies    :reboot_now, 'reboot[adjoin_fx_reboot]', :immediately if new_resource.handle_reboot == true
    environment 'clear_password' => new_resource.password
    action      :run
  end
end
