
service 'stenographer' do
  action [:enable, :start]
  supports [:restart, :status]
end
