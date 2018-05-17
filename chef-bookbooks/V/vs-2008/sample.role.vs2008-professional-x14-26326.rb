name "sample.role.vs2008-professional-x14-26326"
#This file format seems to be best decribed in 
# http://adamcod.es/2013/01/15/vagrant-is-easy-chef-is-hard-part2.html

# The "installers_path" needs to be defined in the solo.rb file or a file that it includes "Chef::Config.from_file "/tmp/vagrant-chef-3/custom-config.rb""
# In the Vagrantfile process, this is defined in the file listed under "Chef.custom_config_path" and right now it called "re-custom-windows"
location = 'http://my-iis-redirect-server/visual-studio'
base_iso_name = "en_visual_studio_2008_professional_x86_dvd_x14-26326.iso"
sp1_iso_name = "en_visual_studio_2008_service_pack_1_x86_dvd_x15-12962.iso"
default_attributes ({
    "vs-2008" => {
      "base-extraction-path" => File.join(Chef::Config[:file_cache_path], "vs2008"),
      "sp1-extraction-path" => File.join(Chef::Config[:file_cache_path], "vs2008sp1"),
      "base-network-location" => location,
      "base-iso-name" => base_iso_name,
      "base-iso-location" => File.join(location, base_iso_name),
      "base-iso-cache-location" => File.join(Chef::Config[:file_cache_path], base_iso_name).gsub("/", "\\"),
      "sp1-iso-location" => File.join(location, sp1_iso_name),
      "sp1-iso-name" => sp1_iso_name,
      "sp1-iso-cache-location" => File.join(Chef::Config[:file_cache_path], sp1_iso_name).gsub("/", "\\"),
      "sp1-installer" => 'vs90sp1\SPInstaller.exe',
      "base-iso-checksum" => "52EBF5731B75CCC460384CE3FD25BC984FB2D828AE51501EBAF0CADC27A33EE9",
      "sp1-iso-checksum" => "580F717269FAA10CF668140EF0A1A264CEC194E20A0083CB0D0004A897CC67",
      "base-display-name" => "Microsoft Visual Studio 2008 Professional Edition - ENU",
      "install_dir" => (ENV['ProgramFiles(x86)'] || 'C:\Program Files (x86)') + '\Microsoft Visual Studio 9.0',
      "devenv_exe_path" => '\Common7\IDE\devenv.exe',
      "install-options" =>  "/q /norestart /full /norestart",
      "sp1-install-options" => '/q /norestart',      
      "sp1-install-log" => File.join(Chef::Config[:file_cache_path], 'vs2008sp1\vs2008sp1.htm').gsub("/", "\\"),
      "timeout" => 6000

    }
  })



run_list(
  "recipe[vs-2008]",
  
)

 