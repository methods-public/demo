
bash 'drop-hops-db' do
  user "root"
  ignore_failure :true
  code <<-EOH
    #{node.ndb.scripts_dir}/mysql-client.sh -e \"DROP DATABASE #{node.apache_hadoop.db}"
  EOH
end
