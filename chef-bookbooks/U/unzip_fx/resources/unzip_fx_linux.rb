#
# cookbook::unzip_fx
# resource::unzip_fx
#
# author::fxinnovation
# description::Unzip resource on linux
#

# Defining resource name
resource_name :unzip_fx

# Declaring provider
provides :unzip_fx, os: 'linux'

# Defining properties
property :source,     String,        required: true
property :target_dir, String,        required: true
property :recursive,  [true, false], default:  false
property :checksum,   String
property :user,       String
property :group,      String
property :mode,       String
property :creates,    String

# Defining default action
default_action :extract

action :extract do
  # Installing the unzip package
  package 'unzip'

  # Making sure target directory exists
  directory new_resource.target_dir do
    owner     new_resource.user      if new_resource.property_is_set?(:user)
    group     new_resource.group     if new_resource.property_is_set?(:group)
    mode      new_resource.mode      if new_resource.property_is_set?(:mode)
    recursive new_resource.recursive
    action    :create
  end

  # Downloading source file
  remote_file "#{Chef::Config['file_cache_path']}/#{new_resource.name}" do
    source   new_resource.source
    checksum new_resource.checksum if new_resource.property_is_set?(:checksum)
    action   :nothing
  end

  # Generating unzip command
  cmd = "unzip #{Chef::Config['file_cache_path']}/"
  cmd << "#{new_resource.name} -d #{new_resource.target_dir}"

  # Executing command
  execute "unzip_#{new_resource.name}" do
    command cmd
    not_if  { ::File.exist?("#{new_resource.target_dir}/#{new_resource.creates}") } if new_resource.property_is_set?(:creates)
    notifies :create, "remote_file[#{Chef::Config['file_cache_path']}/#{new_resource.name}]", :before
  end
end
