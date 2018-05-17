includes4 = Mash.new
includes6 = Mash.new
bag = node['bird']['data_bag']

if !node['bird'].nil? && !node['bird']['config'].nil?
  if !node['bird']['config']['ipv4'].nil? && !node['bird']['config']['ipv4']['data_bags'].nil?
    node['bird']['config']['ipv4']['data_bags'].each do |item|
      bag_item = begin
        data_bag_item(bag, item)
      rescue => ex
        Chef::Log.info("Data bag #{bag} not found (#{ex}), so skipping")
        {}
      end
      includes4 = Chef::Mixin::DeepMerge.merge(includes4, bag_item['include'])
    end
  end

  if !node['bird']['config']['ipv6'].nil? && !node['bird']['config']['ipv6']['data_bags'].nil?
    node['bird']['config']['ipv6']['data_bags'].each do |item|
      bag_item  = begin
        data_bag_item(bag, item)
      rescue => ex
        Chef::Log.info("Data bag #{bag} not found (#{ex}), so skipping")
        {}
      end
      includes6 = Chef::Mixin::DeepMerge.merge(includes6, bag_item['include'])
    end
  end
end

node.set['bird']['ipv4']['includes'] = includes4
node.set['bird']['ipv6']['includes'] = includes6
include_recipe 'bird'

unless node['bird']['config'].nil?
  include_recipe 'bird::ipv4' unless node['bird']['config']['ipv4'].nil?

  include_recipe 'bird::ipv6' unless node['bird']['config']['ipv6'].nil?
end
