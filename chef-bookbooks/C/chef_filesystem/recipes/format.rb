node['filesystem']['format'].each do |device, values|
  next if device == 'defaults'

  options = if !node['filesystem']['format']['defaults'].nil? && !node['filesystem']['format']['defaults'][values['type']].nil?
              Chef::Mixin::DeepMerge.merge(values['options'], node['filesystem']['format']['defaults'][values['type']])
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

  execute "mkfs.#{values['type']} #{optionsstr} #{device}" do
    not_if "blkid -c /dev/null -t TYPE=#{values['type']} -o device #{device} | grep -q #{device}"
  end
end
