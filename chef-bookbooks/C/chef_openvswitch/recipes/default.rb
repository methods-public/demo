
node['openvswitch']['packages'].each do |pkg|
  package pkg
end

node['openvswitch']['bridges'].each do |br, hash|
  bridge br do
    action :create
  end

  hash.each do |k, v|
    case k
    when 'protocols'
      bridge br do
        protocols v
      end
    when 'controller'
      v.each do |ctl|
        controller br do
          target ctl['target']
          mode ctl['mode']
          action :create
        end
      end
    when 'ports'
      v.each do |name, values|
        port name do
          type values['type']
          options values['options']
          action :create
        end
      end
    end
  end
end
