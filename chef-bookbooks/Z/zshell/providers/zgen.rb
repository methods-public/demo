use_inline_resources

action :enable do
  init

  zshell_rcfile 'antigen' do
    user new_resource.user
    source 'rcfile_zgen.erb'
    cookbook 'zshell'
    variables( { :resource => new_resource } )
    order '00'
  end
end

action :disable do
  zshell_rcfile 'antigen' do
    user new_resource.user
    order '00'
    action :delete
  end
end

def init
  directory zgen_home do
    owner new_resource.user
    group Etc.getpwnam(new_resource.user).gid
    mode '0755'
    action :create
  end

  package "git"
  git "#{zgen_home}/repo" do
    repository 'https://github.com/tarjoilija/zgen.git'
    revision new_resource.zgen_revision
    user new_resource.user
    group Etc.getpwnam(new_resource.user).gid
    action :sync
  end
end

def zgen_home
  ::File.join(::Dir.home(new_resource.user), '/.zgen')
end
