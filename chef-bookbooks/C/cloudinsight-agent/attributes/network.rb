default['cloudinsight-agent']['network']['instances'] = [
  {
    'collect_connection_state' => 'false',
    'excluded_interfaces' => ['lo', 'lo0']
  }
]
