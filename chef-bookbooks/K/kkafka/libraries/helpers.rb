#
# Cookbook Name:: kafka
# Libraries:: helpers
#

def kafka_base
  %(kafka_#{node.kkafka.scala_version}-#{node.kkafka.version})
end

def kafka_tar_gz
  [kafka_base, kafka_archive_ext].join('.')
end

def kafka_local_download_path
  ::File.join(Chef::Config.file_cache_path, kafka_tar_gz)
end

def kafka_target_path
  ::File.join(node.kkafka.build_dir, kafka_base)
end

def kafka_jar_path
  if kafka_v0_8_0?
    ::File.join(node.kkafka.install_dir, %(#{kafka_base}.jar))
  else
    ::File.join(node.kkafka.install_dir, 'libs', %(#{kafka_base}.jar))
  end
end

def kafka_installed?
  ::File.exists?(node.kkafka.install_dir) && ::File.exists?(kafka_jar_path)
end

def kafka_download_uri(filename)
  [node.kkafka.base_url, node.kkafka.version, filename].join('/')
end

def kafka_archive_ext
  if kafka_v0_8_0?
    'tar.gz'
  else
    'tgz'
  end
end

def kafka_v0_8_0?
  node.kkafka.version == '0.8.0'
end

def kafka_init_style
  node.kkafka.init_style.to_sym
end

def kafka_init_opts
  @kafka_init_opts ||= Hash.new.tap do |opts|
    case kafka_init_style
    when :sysv
      opts[:env_path] = value_for_platform_family({
        'debian' => '/etc/default/kafka',
        'default' => '/etc/sysconfig/kafka',
      })
      opts[:source] = value_for_platform_family({
        'debian' => 'sysv/debian.erb',
        'default' => 'sysv/default.erb',
      })
      opts[:script_path] = '/etc/init.d/kafka'
      opts[:permissions] = '755'
    when :upstart
      opts[:env_path] = '/etc/default/kafka'
      opts[:source] = value_for_platform_family({
        'default' => 'upstart/default.erb',
      })
      opts[:script_path] = '/etc/init/kafka.conf'
      opts[:provider] = ::Chef::Provider::Service::Upstart
      opts[:permissions] = '644'
    when :systemd
      opts[:env_path] = value_for_platform_family({
        'debian' => '/etc/default/kafka',
        'default' => '/etc/sysconfig/kafka',
      })
      opts[:env_template] = 'systemd/kafka.env.erb'
      opts[:source] = value_for_platform_family({
        'default' => 'systemd/default.erb'
      })
      opts[:script_path] = '/etc/systemd/system/kafka.service'
      opts[:provider] = ::Chef::Provider::Service::Systemd
      opts[:permissions] = '644'
    end
  end
end

def start_automatically?
  !!node.kkafka.automatic_start || restart_on_configuration_change?
end

def restart_on_configuration_change?
  !!node.kkafka.automatic_restart
end

def kafka_service_actions
  actions = [:enable]
  actions << :start if start_automatically?
  actions
end

def kafka_log_dirs
  dirs = []
  dirs += Array(node.kkafka.broker['log.dirs'])
  dirs += Array(node.kkafka.broker.fetch(:log_dirs, []))
  dirs += Array(node.kkafka.broker.fetch(:log, {}).fetch(:dirs, []))
  dirs.uniq!
  dirs
end

def broker_attribute?(*parts)
  parts = parts.map(&:to_s)
  broker = node.kkafka.broker
  if broker.attribute?(parts.join('.'))
    return true
  end
  if broker.attribute?(parts.join('_'))
    return true
  end
  key = parts.pop
  r = parts.reduce(broker) { |b, p| b.fetch(p, b) }
  r.fetch(key, nil)
end

def fetch_broker_attribute(*parts)
  parts = parts.map(&:to_s)
  broker = node.kkafka.broker
  if broker.attribute?(parts.join('.'))
    return broker[parts.join('.')]
  end
  if broker.attribute?(parts.join('_'))
    return broker[parts.join('_')]
  end
  key = parts.pop
  r = parts.reduce(broker) { |b, p| b.fetch(p, b) }
  r[key]
end
