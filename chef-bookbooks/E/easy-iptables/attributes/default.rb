default['easy-iptables']['tables'] = [
  {
    "name" => "filter",
    "policies" => [
      ":INPUT ACCEPT [0:0]",
      ":FORWARD ACCEPT [0:0]",
      ":OUTPUT ACCEPT [0:0]"
    ],
    "rules" => [
      "-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT",
      "-A INPUT -p icmp -j ACCEPT",
      "-A INPUT -i lo -j ACCEPT",
      "-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT",
      "-A INPUT -j REJECT --reject-with icmp-host-prohibited",
      "-A FORWARD -j REJECT --reject-with icmp-host-prohibited"
    ]
  }
]
