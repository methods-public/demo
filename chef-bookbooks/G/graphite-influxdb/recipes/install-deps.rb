include_recipe 'python'

["importlib","logutils"].each do |pip|
    python_pip pip do
        action :install
    end
end

if node['graphite_api']['cache']['enabled'] == true
    python_pip "Flask-Cache" do
        action :install
    end
end

