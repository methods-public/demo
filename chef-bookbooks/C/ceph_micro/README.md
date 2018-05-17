# ceph_micro-cookbook

This cookbook installs ceph using Loïc Dachary script described in
[this article](http://dachary.org/?p=2374).  It adds support for multi platform
and the development files.

Eventually here is the result:

```bash
vagrant@default-ubuntu-1204:/vagrant$ ceph -c  /tmp/micro-ceph/ceph.conf  -s
    cluster e3a14890-0e60-4310-b5c5-54117d04f876
     health HEALTH_OK
     monmap e1: 1 mons at {0=127.0.0.1:6789/0}, election epoch 2, quorum 0 0
     osdmap e5: 1 osds: 1 up, 1 in
      pgmap v41: 72 pgs, 2 pools, 658 bytes data, 1 objects
            2273 MB used, 35045 MB / 39316 MB avail
                  72 active+clean
```

This is not suitable for production environment, but is very convenient for
testing and development.

## Supported Platforms

* Ubuntu (12.04/14.04)
* Debian (7.7)
* CentOS (7.0)

**Notes**: This cookbook has been tested on the listed platforms. It may work
on other platforms with or without modification. Please
[report issues](https://github.com/sathlan/ceph_micro-cookbook/issues) for any
additional platforms so they can be added.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['ceph_micro']['version']</tt></td>
    <td>String</td>
    <td>Which version to use</td>
    <td><tt>giant</tt></td>
  </tr>
  <tr>
    <td><tt>['ceph_micro']['path']</tt></td>
    <td>String</td>
    <td>Path in which to install ceph</td>
    <td><tt>/tmp/micro-ceph</tt></td>
  </tr>
</table>

## Usage

### ceph_micro::default

Include `ceph_micro` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[ceph_micro]"
  ]
}
```

## License and Authors

Author:: Sofer Athlan-Guyot (<chem@sathlan.org>)
