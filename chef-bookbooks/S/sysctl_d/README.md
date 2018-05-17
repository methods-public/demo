Sysctl.d Cookbook
=================
This cookbook contains LWRP to manage files under /etc/sysctl.d

Requirements
------------
#### cookbooks
- `sysctl` - sysctl.d needs sysctl to notify procps service

Usage
-----
#### LWRP Examples
```
sysctl_d "90-postgresql" do
  params "kernel.shmmax" => (node["memory"]["total"].to_i * 1024 * 0.80).to_i,
         "kernel.shmall" => (node["memory"]["total"].to_i * 1024 * 0.80 / 4096).to_i,
         "vm.swappiness" => 0
end
```

```
sysctl_d "90-postgresql" do
  action :remove
end
```

License and Authors
-------------------
Authors: Lev Popov
