yum_package 'Python | install epel-release' do
  package_name  'epel-release'
  action        :upgrade
end

yum_package 'Python | install python-pip' do
  package_name  'python-pip'
  action        :upgrade
end

execute 'Python | Update pip' do
  command 'pip install -U pip'
end

yum_package 'Python | install python-devel' do
  package_name  'python-devel'
  action        :upgrade
end

execute 'Python | VirtualEnv' do
  command 'pip install -U virtualenv'
end

execute 'Python | virtualenvwrapper' do
  command 'pip install -U virtualenvwrapper'
end
