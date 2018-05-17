#
# cookbook::pam_fx
# resource::pam_fx
#
# author::fxinnovation
# description::Add PAM configuration
#

# Defining resource name
resource_name :pam_fx

# Declaring provider
provides :pam_fx, os: 'linux'

# Defining properties
property :lines, Array, required: true

default_action :create

action :create do
  new_resource.lines.each do |line|
    %w( mechanism flag module ).each do |testarg|
      raise "#{testarg} is missing in #{line}" unless line[testarg]
    end
  end
  template "/etc/pam.d/#{new_resource.name}" do
    source 'etc/pam.d/pam-file.erb'
    mode   '0644'
    owner  'root'
    group  'root'
    variables(
      lines: new_resource.lines
    )
    cookbook 'pam_fx'
  end
end
