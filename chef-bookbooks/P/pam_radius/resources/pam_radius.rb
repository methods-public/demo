#
# cookbook::pam_radius
# resource::pam_radius
#
# author::fxinnovation
# description::This resource allows you to install and configure pam_radius.so
#

# Defining resource name
resource_name :pam_radius

# Declaring provider
provides :adjoin_fx, platform_family: %w(rhel debian)

# Defining properties
property :configuration, Array, default: [], sensitive: true

# Defining default action
default_action :install

# Defining install action
action :install do
  # Defining package name to use according to platform family
  package_name = case node['platform_family']
                 when 'rhel'
                   'pam_radius'
                 when 'debian'
                   'libpam-radius-auth'
                 else
                   ''
                 end

  # Defining configuration file according to platofrm family
  configuration_file = case node['platform_family']
                       when 'rhel'
                         '/etc/pam_radius.conf'
                       when 'debian'
                         '/etc/pam_radius_auth.conf'
                       else
                         ''
                       end

  # Installing package
  package package_name

  # Initializing empty array
  lines = []

  # Generating configuration lines from config hash
  new_resource.configuration.each do |config|
    line = config['host'].dup
    line << ":#{config['port'].dup}" unless config['port'].nil?
    line << " #{config['shared_secret'].dup}"
    line << " #{config['timeout'].dup}"
    line << " #{config['source_ip'].dup}" unless config['source_ip'].nil?
    line << " #{config['vrf'].dup}" unless config['vrf'].nil?
    lines.push(line)
  end

  # configuring radius server
  template configuration_file do
    source    'pam_radius.conf.erb'
    cookbook  'pam_radius'
    owner     'root'
    group     'root'
    mode      '0600'
    sensitive true
    variables(
      lines: lines
    )
  end
end
