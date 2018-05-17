major_version = node['platform_version'].split('.')[0] # returns major version, e.g., version 6.4 would return 6

# https://www.perforce.com/perforce-packages
case node['platform_family']
when 'rhel', 'fedora'
  major_version = major_version.to_i < 19 ? raise('Only Fedora 19+ supported!') : '7' if node['platform'] == 'fedora'

  yum_repository 'Perforce' do
    description 'Perforce Repo'
    baseurl "http://package.perforce.com/yum/rhel/#{major_version}/x86_64"
    gpgkey 'https://package.perforce.com/perforce.pubkey'
    action :create
  end

  package 'helix-cli'
when 'debian'
  dist = case major_version # http://askubuntu.com/a/445496
         when '12', '13', '7'
           'precise'
         when '14', '15', '8'
           'trusty'
         else # Assume Ubuntu 16+ or Debian 9+
           'xenial'
         end

  apt_repository 'Perforce' do
    uri 'http://package.perforce.com/apt/ubuntu'
    distribution dist
    components ['release']
    key 'https://package.perforce.com/perforce.pubkey'
  end

  package 'helix-cli'
when 'windows'
  bit = node['kernel']['machine'] == 'x86_64' ? 'x64' : 'x86'

  windows_package 'Helix P4 Command-Line Client' do
    source "#{node['perforce']['download_url']}/#{node['perforce']['release']}/bin.nt#{bit}/helix-p4-#{bit}.exe"
    options '/v"/qn"'
    installer_type :custom
  end
when 'mac_os_x'
  bit = node['kernel']['machine'] == 'x86_64' ? 'x86_64' : 'x86'

  # We put p4 in /opt/perforce and not in /usr/local/bin as that space is locked down by OSX 10.11 and above
  directory '/opt/perforce' do
    owner 'root'
    group 'wheel'
    mode '00755'
    action :create
    recursive true
  end

  remote_file '/opt/perforce/p4' do
    source "#{node['perforce']['download_url']}/#{node['perforce']['release']}/bin.macosx105#{bit}/p4"
    owner 'root'
    group 'wheel'
    mode '00755'
    action :create
  end

  # The below path exists on El Capitan but no longer exists in Sierra but continues to behave in the same way
  directory '/etc/paths.d' do
    owner 'root'
    group 'wheel'
    mode '00755'
    action :create
    recursive true
  end

  file '/etc/paths.d/perforce' do
    content '/opt/perforce'
    owner 'root'
    group 'wheel'
    mode '00755'
    action :create
  end
else
  raise("Platform #{node['platform']} not supported!")
end
