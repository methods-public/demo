#
# cookbook::packer_fx
# resource::packer_fx
#
# author::fxinnovation
# description::Resource that provides a way to install packer
#

# Declaring resource name
resource_name :packer_fx

# Declaring provider
provides :packer_fx, os: 'linux'

# Declaring properties
property :version,           String, required: true
property :install_directory, String, default:  '/opt/packer'
property :source,            String
property :checksum,          String

# Declaring default action
default_action :install

# Declaring install action
action :install do
  # Defining download url
  url = if new_resource.property_is_set?(:source)
          new_resource.source
        else
          case node['kernel']['machine']
          when 'x86_64'
            "https://releases.hashicorp.com/packer/#{new_resource.version}/packer_#{new_resource.version}_linux_amd64.zip"
          when 'i686'
            "https://releases.hashicorp.com/packer/#{new_resource.version}/packer_#{new_resource.version}_linux_386.zip"
          else
            Chef::Log.fatal('packer_fx - Your machine arch is not supported')
          end
        end

  # Create install directory
  directory new_resource.install_directory do
    owner     'root'
    group     'root'
    mode      '0775'
    recursive true
    action    :create
  end

  # Download and unzip file
  unzip_fx 'packer' do
    source     url
    target_dir new_resource.install_directory
    checksum   new_resource.checksum if new_resource.property_is_set?(:checksum)
    user       'root'
    group      'root'
    mode       '0755'
    creates    'packer'
  end

  # Create sim link into the path
  link '/usr/local/bin/packer' do
    link_type :symbolic
    to        "#{new_resource.install_directory}/packer"
  end
end
