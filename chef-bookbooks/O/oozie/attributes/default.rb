include_attribute "kagent"
include_attribute "apache_hadoop"
include_attribute "hops"
include_attribute "hadoop_spark"


default.oozie.version                  = "4.2.0"
default.oozie.user                     = node.apache_hadoop.yarn.user
default.oozie.group                    = node.apache_hadoop.group
default.oozie.url                      = "#{node.download_url}/oozie-#{node.oozie.version}-distro.tar.gz"
default.oozie.systemd                  = "true"
default.oozie.dir                      = "/srv"
default.oozie.base_dir                 = "/srv/oozie-" + "#{node.oozie.version}"
default.oozie.home                     = "/srv/oozie"


