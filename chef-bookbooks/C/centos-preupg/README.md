# centos-preupg-cookbook

Installs the CentOS 7 pre-upgrade tool.

## Supported Platforms

CentOS 6.6 ONLY. Earlier versions of CentOS must be updated to 6.6 first.
RedHat uses a different pre-upgrade tool. For other distributions, this
cookbook is of course meaningless.

## Attributes

This cookbook is too trivial for attributes

## Usage

### centos-preupg::default

Include `centos-preupg` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[centos-preupg::default]"
  ]
}
```

This recipe will do the following:

- install and enable the appropriate repository to install the upgrade
  tools.
- install the RPMs for the upgrade tools.
- clean up the selinux sandbox module if it exists; the upgrade will
  flag it as incompatible.
- Run the preupg tool only if it has not yet run before
  (that is, if the /root/preupgrade directory does not exist).

## License and Authors

Author:: North County Tech Center, LLC (<kkeane@4nettech.com>)
License:: GPLv3

