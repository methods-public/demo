default['qpid'] = {
  'user' => 'qpidd',
  'group' => 'qpidd',
  'restart' => true
}

default['qpid']['qpidd'] = {
  'cluster-mechanism' => %w(DIGEST-MD5 ANONYMOUS),
  'auth' => true
}

default['qpid']['sasl'] = {
  'pwcheck_method' => 'auxprop',
  'auxprop_plugin' => 'sasldb',
  'sasldb_path'    =>  '/var/lib/qpidd/qpidd.sasldb',
  'sql_select'     =>  'dummy select'
}

default['qpid']['qpidc'] = {
}
