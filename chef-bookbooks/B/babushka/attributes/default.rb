default['babushka'].tap do |n|
  n['git']['clone_path'] = '/opt/babushka'
  n['git']['repo_path'] = 'https://github.com/benhoskings/babushka.git'
  n['git']['update_strategy'] = :sync
  n['git']['revision'] = 'v0.19.1'
end
