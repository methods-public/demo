
include_recipe '::default'
include_recipe 'as-asset::create'

#設定ファイルコピー
files = %w(composer.json)
files.each do |item|
  cookbook_file "#{node[:asset][:root_path]}/#{item}" do
    # user node['asset']['maintenance']['user']
    # group node['asset']['maintenance']['group']
    source "#{item}"
    not_if { ::File.exists?("#{node[:asset][:root_path]}/#{item}") }
  end
end

include_recipe '::install'


# #composer.json インストール
# execute 'composer.json install' do
#   cwd node[:asset][:root_path]
#   command 'composer install'
# end
#
# #ドキュメントルート書き換え
# set_document_root node[ :asset ][ :root_path ] + '/web' do
# end
