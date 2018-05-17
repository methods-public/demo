default['yum']['newrelic']['description'] = 'New Relic packages for Enterprise Linux 5 - $basearch'
default['yum']['newrelic']['baseurl'] = 'http://yum.newrelic.com/pub/newrelic/el5/$basearch'
default['yum']['newrelic']['gpgkey'] = 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-NewRelic'
default['yum']['newrelic']['gpgcheck'] = true
default['yum']['newrelic']['enabled'] = true
default['yum']['newrelic']['managed'] = true
