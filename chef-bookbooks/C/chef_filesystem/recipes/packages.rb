
pkgs = []

node['filesystem']['format'].each do |_device, values|
  unless node['filesystem']['packages'][values['type']].nil?
    pkgs |= node['filesystem']['packages'][values['type']]
  end
end

unless node['filesystem']['fstypes'].nil? || node['filesystem']['fstypes'].empty?
  pkgs |= node['filesystem']['fstypes']
end

pkgs.each do |pkg|
  package pkg
end
