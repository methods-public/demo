property :node_build_root, String, name_property: true
property :git_url, String, default: 'https://github.com/nodenv/node-build.git'
property :git_revision, String, default: 'master'
property :user, String

action :install do
  git_client 'default'

  directory ::File.dirname(new_resource.node_build_root) do
    owner new_resource.user if new_resource.user
    group new_resource.user if new_resource.user
    recursive true
    mode '0755'
  end

  git new_resource.node_build_root do
    repository new_resource.git_url
    reference new_resource.git_revision
    user new_resource.user if new_resource.user
    group new_resource.user if new_resource.user
    action :checkout
    not_if { ::File.exist?(::File.join(new_resource.node_build_root, 'bin', 'node-build')) }
  end
end
