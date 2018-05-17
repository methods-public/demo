# Delete the Redis package config files (we wont use them)
%w(
/etc/init.d/redis
/etc/redis.conf
/etc/rc.d/init.d/redis
/etc/rc.d/init.d/redis-sentinel
/etc/redis-sentinel.conf
/etc/init.d/redis-sentinel
/usr/lib/systemd/system/redis.service
/usr/lib/tmpfiles.d/redis.conf
/usr/lib/systemd/system/redis-sentinel.service
).each do |file|
  file file do
    action :delete
    only_if { ::File.exist?(file) }
  end
end
