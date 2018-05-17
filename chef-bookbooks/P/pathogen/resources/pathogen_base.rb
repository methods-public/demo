resource_name :pathogen_base

property :users, Array, required: true

default_action :install

action :install do
  users.each do |user|
    home = Dir.home(user)
    vimrc = ::File.join(home, '.vimrc')
    vim = ::File.join(home, '.vim')
    vim_autoload = ::File.join(vim, 'autoload')
    vim_bundle = ::File.join(vim, 'bundle')

    [vim, vim_autoload, vim_bundle].each do |dir|
      directory dir do
        mode '0755'
      end
    end

    remote_file ::File.join(vim_autoload, 'pathogen.vim') do
      source 'https://tpo.pe/pathogen.vim'
      mode   '0755'
      owner  user
    end

    file vimrc do
      action :create_if_missing
    end

    bash 'add pathogen to .vimrc' do
      code "echo 'execute pathogen#infect()' >> #{vimrc}"

      not_if do
        contents = ::File.read(vimrc)
        contents.match(/execute pathogen#infect\(\)/)
      end
    end
  end
end
