# Recipe for installing LogDNA Agent via Advanced Packaging Tool (APT)

## Adding LogDNA Agent Repo to /etc/apt/sources.list.d/:
bash 'add-apt-repository' do
  code <<-EOH
    if [ ! -d /etc/apt/sources.list.d/ ]; then mkdir -p /etc/apt/sources.list.d/; fi
    echo 'deb http://repo.logdna.com stable main' | sudo tee /etc/apt/sources.list.d/logdna.list
    wget -O- https://s3.amazonaws.com/repo.logdna.com/logdna.gpg | sudo apt-key add -
    EOH
  creates '/etc/apt/sources.list.d/logdna.list'
  action :run
  retries 5
end

## Updating the sources; so, LogDNA Agent Repo will be in effect:
apt_update

## Install LogDNA Agent:
apt_package 'logdna-agent' do
  default_release 'stable'
  action :install
end
