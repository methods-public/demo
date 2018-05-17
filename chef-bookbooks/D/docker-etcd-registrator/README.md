docker-etcd-registrator Cookbook
================================
Chef cookbook for the docker-etcd-registrator for Vulcand made by @psi-4ward.

Requirements
------------
- `git` - pulls the fresh version from git since the npm published one is outdated
- `nodejs`
- `poise-service`

Attributes
----------
Most of the provided attributes are passed as the `env` variables, so in principle
it's not really needed to specify anything to get the basic config.
All the attributes have a `['docker-etcd-registrator']` root, e.g. `['attribute1']`
in the following table means `['docker-etcd-registrator']['attribute1']`.

#### docker-etcd-registrator::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Resource</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['conf_dir']</tt></td>
    <td>String</td>
    <td><tt>:conf_dir</tt></td>
    <td>Config directory</td>
    <td><tt>/etc/docker-etcd-registrator</tt></td>
  </tr>
  <tr>
    <td><tt>['binary']</tt></td>
    <td>String</td>
    <td><tt>:binary</tt></td>
    <td>Binary to run</td>
    <td><tt>/usr/local/bin/docker-etcd-registrator</tt></td>
  </tr>
  <tr>
    <td><tt>['run_user']</tt></td>
    <td>String</td>
    <td><tt>:run_user</tt></td>
    <td>User to run</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>['hostname']</tt></td>
    <td>String</td>
    <td><tt>:hostname</tt></td>
    <td>Hostname of the system</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['register']</tt></td>
    <td>String</td>
    <td><tt>:register</tt></td>
    <td>If 'public' - register only the port which binds to the host interface (docker -p)</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['register_public_ip']</tt></td>
    <td>String</td>
    <td><tt>:register_public_ip</tt></td>
    <td>Binding IP if it was not specified explicitly in the docker run opts</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['force_public_ip']</tt></td>
    <td>String</td>
    <td><tt>:force_public_ip</tt></td>
    <td>Force using the specified IP even if the binding IP was specified in the docker run opts</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['skydns_prefix']</tt></td>
    <td>String</td>
    <td><tt>:skydns_prefix</tt></td>
    <td>Etcd prefix for SkyDNS</td>
    <td><tt>/skydns</tt></td>
  </tr>
  <tr>
    <td><tt>['vulcand_prefix']</tt></td>
    <td>String</td>
    <td><tt>:vulcand_prefix</tt></td>
    <td>Etcd prefix for Vulcand</td>
    <td><tt>/vulcand</tt></td>
  </tr>
  <tr>
    <td><tt>['docker_host']</tt></td>
    <td>String</td>
    <td><tt>:docker_host</tt></td>
    <td>Docker socket to listen</td>
    <td><tt>/var/run/docker.sock</tt></td>
  </tr>
  <tr>
    <td><tt>['docker_tls_verify']</tt></td>
    <td>String</td>
    <td><tt>:docker_tls_verify</tt></td>
    <td>Use TLS to communicate with docker (used for docker-modem)</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['docker_cert_path']</tt></td>
    <td>String</td>
    <td><tt>:docker_cert_path</tt></td>
    <td>Directory that contains ca.pem, cert.pem and key.pem (names hardcoded)</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['etcd_endpoints']</tt></td>
    <td>String</td>
    <td><tt>:etcd_endpoints</tt></td>
    <td>Connection endpoints for Etcd</td>
    <td><tt>http://127.0.0.1:4001</tt></td>
  </tr>
  <tr>
    <td><tt>['etcd_cafile']</tt></td>
    <td>String</td>
    <td><tt>:etcd_cafile</tt></td>
    <td>CA certificate for Etcd</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['etcd_certfile']</tt></td>
    <td>String</td>
    <td><tt>:etcd_certfile</tt></td>
    <td>Client certificate for Etcd</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['etcd_keyfile']</tt></td>
    <td>String</td>
    <td><tt>:etcd_keyfile</tt></td>
    <td>Client key for Etcd</td>
    <td><tt></tt></td>
  </tr>
</table>

Usage
-----
###Install
Include `docker-etcd-registrator` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[docker-etcd-registrator]"
  ]
}
```

###Config
Two different approaches can be used to set the parameters

####JSON attributes
Include in your node description
```json
{
  "docker-etcd-registrator": {
    "Attribute1": "Value1"
  }
}
```

####Resource-based
In your recipe include

```ruby
docker-etcd-registrator 'config' do
  Attribute1 Value1
end
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like <tt>add_component_x</tt>)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: 
Petr Belyaev <upcfrost@gmail.com>
