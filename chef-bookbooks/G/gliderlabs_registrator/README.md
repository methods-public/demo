gliderlabs_registrator Cookbook
===============================
This cookbook can be used to install the Gliderlabs Registrator.

Requirements
------------
## Supported Platforms

- Debian/Ubuntu
- RHEL/CentOS

## Cookbooks
- `docker` - If the `docker` or `source_docker` install method is chosen
- `golang` - If the `source` install method is chosen
- `yum`, `apt`, `zypper` - If `package` install method is chosen

## Packages
Supported directory needs to be installed, e.g. Consul or Etcd. Please check the 
http://gliderlabs.com/registrator/latest/user/backends/

Attributes
----------
#### gliderlabs_registrator::default
JSON: `['value']` == `node['gliderlabs_registrator']['value']`

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['install_method']</tt></td>
    <td>String</td>
    <td>Installation method. Possible values: <tt>'package'</tt>, <tt>'docker'</tt>, <tt>'source_docker'</tt>, <tt>'source'</tt>. Method 'package' requires 'addrepo' recipe to add custom repository.</td>
    <td><tt>'source_docker'</tt></td>
  </tr>
  <tr>
    <td><tt>['registrator_repo']</tt></td>
    <td>String</td>
    <td>Docker repo for 'docker' installation method</td>
    <td><tt>'gliderlabs/registrator'</tt></td>
  </tr>
  <tr>
    <td><tt>['registrator_tag']</tt></td>
    <td>String</td>
    <td>Docker repo tag for 'docker' installation method</td>
    <td><tt>'latest'</tt></td>
  </tr>
  <tr>
    <td><tt>['golang_docker_repo']</tt></td>
    <td>String</td>
    <td>Docker repo with Go image for 'source_docker' install method</td>
    <td><tt>'golang'</tt></td>
  </tr>
  <tr>
    <td><tt>['golang_docker_tag']</tt></td>
    <td>String</td>
    <td>Docker repo tag for 'source_docker' install method</td>
    <td><tt>'latest'</tt></td>
  </tr>
  <tr>
    <td><tt>['bin_path']</tt></td>
    <td>String</td>
    <td>Path where to place the binary for 'source_docker' and 'source' methods</td>
    <td><tt>'/usr/local/bin'</tt></td>
  </tr>
  <tr>
    <td><tt>['src_command']</tt></td>
    <td>String</td>
    <td>Command to use to get sources for 'source_docker' and 'source' methods</td>
    <td><tt>'go get github.com/gliderlabs/registrator'</tt></td>
  </tr>
  <tr>
    <td><tt>['backend']</tt></td>
    <td>String</td>
    <td>Directory backend type. Check documentation for the list of supported backends.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['backend_url']</tt></td>
    <td>String</td>
    <td>Directory backend URL</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['backend_port']</tt></td>
    <td>String</td>
    <td>Directory backend port</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['cleanup']</tt></td>
    <td>String</td>
    <td>Remove dangling services</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['deregister']</tt></td>
    <td>String</td>
    <td>Deregister exited services "always" or "on-success"</td>
    <td><tt>'always'</tt></td>
  </tr>
  <tr>
    <td><tt>['internal']</tt></td>
    <td>String</td>
    <td>Use internal ports instead of published ones</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ip']</tt></td>
    <td>String</td>
    <td>IP for ports mapped to the host</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['resync']</tt></td>
    <td>String</td>
    <td>Frequency with which services are resynchronized</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['retry-attempts']</tt></td>
    <td>String</td>
    <td>Max retry attempts to establish a connection with the backend. Use -1 for infinite retries</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['retry-interval']</tt></td>
    <td>String</td>
    <td>Interval (in millisecond) between retry-attempts.</td>
    <td><tt>2000</tt></td>
  </tr>
  <tr>
    <td><tt>['tags']</tt></td>
    <td>String</td>
    <td>Append tags for all registered services</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ttl']</tt></td>
    <td>String</td>
    <td>TTL for services (default is no expiry)</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ttl-refresh']</tt></td>
    <td>String</td>
    <td>Frequency with which service TTLs are refreshed</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['docker_bind']</tt></td>
    <td>String</td>
    <td>Docker socket to listen</td>
    <td><tt>'/var/run/docker.sock:/tmp/docker.sock'</tt></td>
  </tr>
</table>

## Usage

### gliderlabs_registrator::default

Include `gliderlabs_registrator` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[gliderlabs_registrator::default]"
  ]
}
```

Alternatively, you can include it within your own recipe:

```ruby
include_recipe 'gliderlabs_registrator::default'
```

## License and Authors

Author:: Petr Belyaev <upcfrost@gmail.com>
