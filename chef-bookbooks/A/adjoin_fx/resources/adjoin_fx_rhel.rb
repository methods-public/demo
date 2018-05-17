#
# cookbook::adjoin_fx
# resource::adjoin_fx
#
# author::fxinnovation
# description::Executing an adjoin on a rhel machine
#

# Declaring resource name
resource_name :adjoin_fx

# Declaring provider
provides :adjoin_fx, platform_family: 'rhel'

# Defining properties
property :target_ou,           String
property :os_name,             String
property :os_version,          String
property :membership_software, %w(samba adcli)
property :one_time_password,   String
property :client_software,     %w(sssd winbind)
property :server_software,     %w(active-directory ipa)
property :server,              String
property :no_password,         [true, false],           default:  false
property :username,            String,                  required: true
property :password,            String,                  required: true, sensitive: true
property :domain,              String,                  required: true

# Declaring default action
default_action :join

# Declaring join action
action :join do
  # Declare needed packages
  packages = %w(
    sssd
    adcli
    realmd
    samba-common-tools
    krb5-libs
    krb5-workstation
  )

  # Installing needed packages
  packages.each do |package_name|
    package package_name
  end

  # Initiating empty option string
  options_string = ''

  # Generating options_string using properties
  options_string << "--target-ou=#{new_resource.target_ou} "                     if property_is_set?(:target_ou)
  options_string << "--os-name=#{new_resource.os_name} "                         if property_is_set?(:os_name)
  options_string << "--os-version=#{new_resource.os_version} "                   if property_is_set?(:os_version)
  options_string << "--membership-software=#{new_resource.membership_software} " if property_is_set?(:membership_software)
  options_string << "--one-time-password=#{new_resource.one_time_password} "     if property_is_set?(:one_time_password)
  options_string << "--client-sofware=#{new_resource.client_software} "          if property_is_set?(:client_software)
  options_string << "--server_software=#{new_resource.server_software} "         if property_is_set?(:server_software)
  options_string << '--no-password '                                             if new_resource.no_password == true

  # Defining what property to use to join the domain
  join_fqdn = if property_is_set?(:server)
                new_resource.server
              else
                new_resource.domain
              end

  # Joining AD
  # NOTE: Putting the password as an env var is safer because it won't
  # be in the history or any output.
  execute "adjoin_fx_#{new_resource.name}" do
    environment 'JOIN_USER_SECRET' => new_resource.password
    command     "echo ${JOIN_USER_SECRET} | realm join -v --user=#{new_resource.username} #{join_fqdn} #{options_string} --unattended"
    not_if      "realm list | grep '^#{new_resource.domain}'"
    retries     3
    retry_delay 5
  end
end
