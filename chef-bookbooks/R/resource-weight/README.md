# resource-weight

This cookbook introduces **weight** property on resources.

This notion emerged during a discussion of London chef summit in Oct 2016.

Our need was to qualify resources with a high impact (_i.e_ that cause downtime on the node) such as reboots, reinstallation, some service restarts. Those resources would be protected automatically by a [choregraphie](https://github.com/criteo-cookbooks/choregraphie).

This would solve the necessity to manually manage lists of these resources.

Someone suggested to generalize the **high impact** flag by a **weight** property to use it for other use cases.

Example use cases:
- graph impact of chef-client run over time (weighting each resource)
- adopt rules to avoid running chef-client during peak hours if its impact has a weigh above a threshold
- simplify definitions of [choregraphies](https://github.com/criteo-cookbooks/choregraphie)

Note: The intent of this cookbook is to validate the interest of a feature that could be integrated in chef.

Usage
-----

All resources now have a property **weight**.

In recipes:
```
service 'network' do
  weight 5
  action :start
end

execute 'something' do
  action :restart, 'service[network]'
end
```

It is possible to add a default weight to all instances of a given resource.

In attributes:
```
default['resource-weight']['reboot']['default-weight'] = 5
```
