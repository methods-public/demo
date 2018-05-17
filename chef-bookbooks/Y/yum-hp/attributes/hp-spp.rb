default['yum']['hp-spp']['repositoryid'] = 'hp-spp'

default['yum']['hp-spp']['gpgkey'] = 'http://downloads.linux.hpe.com/SDR/hpePublicKey2048_key1.pub'

case node['platform_version'].to_i
when 6
  default['yum']['hp-spp']['description'] = 'HP Service Pack Packages for Enterprise Linux 6 - $basearch'
  default['yum']['hp-spp']['baseurl'] = 'http://downloads.linux.hpe.com/repo/spp/rhel/6/$basearch/current'
when 7
  default['yum']['hp-spp']['description'] = 'HP Service Pack Packages for Enterprise Linux 7 - $basearch'
  default['yum']['hp-spp']['baseurl'] = 'http://downloads.linux.hpe.com/repo/spp/rhel/7/$basearch/current'
end

default['yum']['hp-spp']['gpgcheck'] = true
default['yum']['hp-spp']['enabled'] = true
default['yum']['hp-spp']['managed'] = true
