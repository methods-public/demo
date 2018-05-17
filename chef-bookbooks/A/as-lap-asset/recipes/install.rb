
include_recipe '::default'
include_recipe 'as-asset::install'

#composer.json インストール
execute 'composer.json install' do
  cwd node[:asset][:root_path]
  command 'composer install'
end

#ドキュメントルート書き換え
set_document_root node[ :asset ][ :root_path ] + '/web' do
end
