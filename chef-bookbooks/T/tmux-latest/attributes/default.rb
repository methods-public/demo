default['platform_specific_pkgs'] =
  if node['platform_family'] == 'rhel'
    %w(libevent-devel ncurses-devel make)
  elsif node['platform_family'] == 'debian'
    %w(libevent-dev ncurses-dev pkg-config)
  else
    raise "Platform not supported: #{node['platform_family']}"
  end

default['tmux'].tap do |tmux|
  tmux['destination'] = File.join('/', 'usr', 'local', 'tmux')
  tmux['repo']        = 'https://github.com/tmux/tmux.git'
end
