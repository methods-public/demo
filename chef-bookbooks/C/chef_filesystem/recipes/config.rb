node['filesystem']['config'].each do |device, values|
  next if device == 'defaults'

  options = if !node['filesystem']['config']['defaults'].nil? && !node['filesystem']['config']['defaults'][values['type']].nil?
              Chef::Mixin::DeepMerge.merge(values['options'], node['filesystem']['config']['defaults'][values['type']])
            else
              values['options']
            end

  detect_key = ''
  detect_val = ''
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
      if k == 'L'
        detect_key = 'by-label'
        detect_val = v
      end
      if k.length > 1
        "--#{k} #{v}"
      else
        "-#{k} #{v}"
      end
    end
  end.join(' ')

  cmd = ''
  case values['type']
  when 'ext2', 'ext3', 'ext4'
    cmd = 'tune2fs'
  end

  case detect_key
  when 'by-label'
    detect_cmd = "test -b /dev/disk/by-label/#{detect_val}"
  end

  execute "udevadm trigger #{device}" do
    command 'udevadm trigger --type=devices --subsystem-match=block'
    action :nothing
  end

  execute "#{cmd} #{optionsstr} #{device}" do
    not_if detect_cmd
    notifies :run, "execute[udevadm trigger #{device}]", :immediately
  end
end
