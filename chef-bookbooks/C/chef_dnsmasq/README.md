chef_dnsmasq
==========

Installs/Configures dnsmasq via node attributes


Example
=======

role attributes

```
"dnsmasq" => {
  "conf" => {
    "dhcp" => {
      "dhcp-authoritative" => true,
      "dhcp-broadcast" => true,
      "dhcp-no-override" => true,
      "dhcp-vendorclass" => "set:pxe,PXEClient",
      "dhcp-option-force" => [ "176,1" ],
      "dhcp-match" => [ "set:ipxe,175" ],
      "dhcp-boot" => [ "tag:#ipxe,bin/ipxe.pxe" ],
      "dhcp-ignore" => [ "!pxe" ],
      "leasefile-ro" => true,
      "log-dhcp" => true,
      "log-queries" => true,
      "no-ping" => true
    },
    "tftp" => {
      "enable-tftp" => true,
      "tftp-no-blocksize" => true,
      "tftp-root" => "/srv/pxe",
      "no-ping" => true
    },
    "dns" => {
      "no-hosts" => true,
      "address" => {
        "2001:db8:0:f103:3837:90ff:feed:a279" => [ "boot" ]
      }
    },
    "global" => {
      "interface" => [ "eth0", "eth1", "dummy0" ],
      "except-interface" => [ "lo" ],
      "bind-interfaces" => true
    }
  }
}
```
