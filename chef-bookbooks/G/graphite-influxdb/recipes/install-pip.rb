include_recipe 'python'

python_pip 'graphite_influxdb' do
    action :install
end

