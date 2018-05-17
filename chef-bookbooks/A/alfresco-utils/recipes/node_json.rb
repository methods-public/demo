file '/tmp/node.json' do
  content Chef::JSONCompat.to_json_pretty(node.to_hash)
end
