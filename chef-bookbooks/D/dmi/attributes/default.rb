#
# Cookbook Name::	dmi
# Description::   Default attributes
# Recipe::        default.rb
#

case node['platform_family']
when 'windows'
  # --[ DMI Attribute ]--
  default['dmi']['package']['name']      = 'GnuWin32: DmiDecode-2.10'
  default['dmi']['package']['url']       = 'http://downloads.sourceforge.net/gnuwin32/dmidecode-2.10-setup.exe'
  default['dmi']['package']['sha256sum'] = 'f1ad42daaf68eb0b61aad47144def4beada098b313ce9f61442589c354411128'
  # --[ NOTE: Also used in OHAI ]--
  default['dmi']['path'] = 'C:\Program Files (x86)\GnuWin32\sbin'
end
