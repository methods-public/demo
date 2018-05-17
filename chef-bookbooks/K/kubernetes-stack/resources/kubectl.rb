resource_name :kubectl

property :version, String, default: ''
property :binary_path, String, default: '/usr/local/bin/kubectl'

default_action :install

load_current_value do
end

action :install do
  platform_cmd = Mixlib::ShellOut.new('uname')
  platform_cmd.run_command
  platform_cmd.error!
  platform = platform_cmd.stdout.strip.downcase

  version = new_resource.version

  arch_cmd = Mixlib::ShellOut.new('uname -m')
  arch_cmd.run_command
  arch_cmd.error!
  arch = arch_cmd.stdout.strip

  case arch
  when 'x86', 'i686', 'i386'
    arch = '386'
  when 'x86_64', 'aarch64'
    arch = 'amd64'
  when 'armv5*'
    arch = 'armv5'
  when 'armv6*'
    arch = 'armv6'
  when 'armv7*'
    arch = 'armv7'
  else
    arch = 'default'
  end

  if version.empty?
    latest_version_url = 'curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt'
    version_cmd = Mixlib::ShellOut.new(latest_version_url)
    version_cmd.run_command
    version_cmd.error!
    version = version_cmd.stdout.strip
  end

  # Command to check if we should be installing kubectl or not.
  existing_version_cmd = Mixlib::ShellOut.new("kubectl version --short --client | cut -d ':' -f2")
  existing_version_cmd.run_command

  if existing_version_cmd.stderr.empty? && !existing_version_cmd.stdout.empty?
    existing_version = existing_version_cmd.stdout.strip
  end

  if existing_version.to_s != version.to_s
    bash 'clean up the mismatched kubectl version' do
      code <<-EOH
        kubectl_binary=$(which kubectl);
        rm -rf $kubectl_binary
        EOH
      only_if 'which kubectl'
    end

    download_url = "https://storage.googleapis.com/kubernetes-release/release/#{version}/bin/#{platform}/#{arch}/kubectl"

    remote_file binary_path do
      source download_url
      mode '0755'
      not_if { ::File.exist?(binary_path) }
    end

    # Check bash-completion is installed
    if platform?('ubuntu')
      bash 'check exist and install bash-completion' do
        code <<-EOH
            apt-get install bash-completion
            . /etc/bash_completion
            EOH
        not_if { ::File.exist?('/etc/bash_completion') && ::File.exist?('/usr/share/bash-completion/bash_completion') }
      end
    end

    if platform?('centos')
      execute 'check exist and install bash-completion' do
        command 'yum install -y bash-completion'
        not_if { ::File.exist?('/etc/profile.d/bash_completion.sh') && ::File.exist?('/usr/share/bash-completion/bash_completion') }
      end

      bash 'add it to the bash profile' do
        code <<-EOH
            source /etc/profile.d/bash_completion.sh
            EOH
        only_if { node['platform_version'].to_f > 7.0 }
      end
    end

    # Delete kubect autocomplete if existing
    execute 'delete kubectl autocomplete' do
      action :run
      command 'rm -rf /etc/bash_completion.d/kubectl'
      user 'root'
      only_if 'test -f /etc/bash_completion.d/kubectl'
    end

    # Install kubectl autocomplete
    execute 'install kubectl autocomplete' do
      action :run
      command 'kubectl completion bash > /etc/bash_completion.d/kubectl'
      creates '/etc/bash_completion.d/kubect'
      user 'root'
    end
  end
end

action :remove do
  execute 'remove kubectl' do
    command "rm -rf #{binary_path}"
    only_if 'which kubectl'
  end
end
