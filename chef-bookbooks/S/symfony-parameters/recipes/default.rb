node['symfony']['config'].each do |name, config|
  unless config.key?('config')
    raise 'Config must include the name of the config file'
  end

  unless config.key?('file')
    raise 'Config must include the name of the file you want created'
  end

  unless node['symfony']['configset'].key?(config[:config])
    raise "node['symfony']['configset'] does not have a config for `#{config[:config]}`"
  end

  configset = Chef::Mixin::DeepMerge.hash_only_merge(
    node['symfony']['configset']['default'],
    node['symfony']['configset'][config['config']]
  )

  unless node[:symfony][:configset].key?(config[:config])
    raise "node[:symfony][:configset] does not have a config for `#{config[:config]}`"
  end

  puts configset

  template name do
    path config['file']
    cookbook configset['cookbook']
    source configset['template']
    mode '0444'
    sensitive true
    owner node['symfony']['user']
    group node['symfony']['group']
    variables(
      'param' => configset['parameters']
    )
  end
end
