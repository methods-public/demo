apt_package 'Python | install python-pip' do
  package_name  'python-pip'
  action        :upgrade
end

execute 'Python | Update pip' do
  command 'pip install -U pip'
end

apt_package 'Python | install python-dev' do
  package_name  'python-dev'
  action        :upgrade
end

execute 'Python | VirtualEnv' do
  command 'pip install -U virtualenv'
end

execute 'Python | virtualenvwrapper' do
  command 'pip install -U virtualenvwrapper'
end

apt_package 'Python | virtualenvwrapper console support' do
  package_name  'virtualenvwrapper'
  action        :upgrade
end
