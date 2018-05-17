node['filesystem']['mount'].each do |device, values|
  next if device == 'defaults'

  options = if !node['filesystem']['mount']['defaults'].nil? && !node['filesystem']['mount']['defaults'][values['type']].nil?
              Chef::Mixin::DeepMerge.merge(values['options'], node['filesystem']['mount']['defaults'][values['type']])
            else
              values['options']
            end

  optionsstr = options.map do |k, v|
    case v
    when TrueClass, FalseClass
      if k.length > 1
        "--#{k}"
      else
        "-#{k}"
      end
    when Array
      if k.length > 1
        "--#{k} #{v.join(',')}"
      else
        "-#{k} #{v.join(',')}"
      end
    else
      if k.length > 1
        "--#{k} #{v}"
      else
        "-#{k} #{v}"
      end
    end
  end.join(' ')

  directory values['path'] do
    owner 'root'
    mode '0755'
    recursive true
  end

  execute "mount -t #{values['type']} #{optionsstr} #{device} #{values['path']}" do
    not_if "findmnt --source #{device} --target #{values['path']}"
  end
end
