# WHMCS needed files

cookbook_file '/var/www/html/whmcswtf.php' do
  source 'whmcswtf.php'
  mode '0644'
end
