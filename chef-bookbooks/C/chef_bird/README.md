chef_bird
=============

Example attributes
===================
```
{
  "bird" => {
    "ipv4" => {
      "log" => {
        "syslog" =>  [ "error", "warning", "fatal" ]
      },
      "include" => [ "/etc/bird/conf.d4/*" ],
      "router id" => "10.220.10.26",
      "table" => [ "vps" ],
      "protocol" => {
        "direct" => {
          "interface" => [ "bond1", "vif*.0" ]
        },
        "kernel kernel1" => {
          "learn" => "on",
          "scan time" => 10,
          "import" => "all"
        },
        "kernel kernel2" => {
          "table" => "vps",
          "scan time" => 10,
          "kernel table" => 20,
          "export" => "all"
        },
        "device" => {
          "scan time" => 5
        },
        "static" => {
          "import" => "all",
          "export" => "all"
        },
        "ospf ospf1" => {
          "table" => "vps",
          "import" => "filter reject_default_route",
          "export" => "all",
          "tick" => 3,
          "area 0.0.0.0" => {
            "interface \"bond1\"" => {
              "cost" => 5,
              "hello" => 5,
              "retransmit" => 2,
              "wait" => 10,
              "dead" => 20
            },
            "interface \"vif*.0\"" => {
              "stub" => "on"
            }
          }
        }
      }
    }
  }
}
```                    

Example data_bag
================
```
{
  "id": "reject_default_route",
  "net": "ipv4",
  "include": {
    "reject_default_route": {
      "source": [
        "filter reject_default_route {",
        " if ( net = 0.0.0.0/0 ) then reject;",
        " else accept;",
        "}" ]
    }
  }
}
```
