#
# cookbook::unzip_fx
# resource::unzip_fx
#
# author::fxinnovation
# description::Unzip resource for windows
#

# Defining resource name
resource_name :unzip_fx

# Declaring provider
provides :unzip_fx, platform_family: 'windows'

# Defining properties
property :source,     String, required: true
property :checksum,   String
property :target_dir, String, required: true
property :creates,    String

# Defining default action
default_action :extract

action :extract do
  # Creating target dir
  directory new_resource.target_dir do
    action    :create
    recursive true
  end

  # Fetching remote file
  remote_file "#{Chef::Config['file_cache_path']}/#{new_resource.name}.zip" do
    source   new_resource.source
    checksum new_resource.checksum if new_resource.property_is_set?(:checksum)
    action   :nothing
  end

  cmd = '& { Add-Type -A \'System.IO.Compression.FileSystem\'; '
  cmd << '[IO.Compression.ZipFile]::ExtractToDirectory('
  cmd << "'#{Chef::Config['file_cache_path']}\\#{new_resource.name}.zip', "
  cmd << "'#{new_resource.target_dir}'); }"

  powershell_script "unzip_#{new_resource.name}.zip" do
    code     cmd
    not_if   { ::File.exist?("#{new_resource.target_dir}/#{new_resource.creates}") } if new_resource.property_is_set?(:creates)
    notifies :create, "remote_file[#{Chef::Config['file_cache_path']}/#{new_resource.name}.zip]", :before
  end
end
