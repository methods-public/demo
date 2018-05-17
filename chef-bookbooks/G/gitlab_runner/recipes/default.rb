case node['platform_family']
when 'debian'
  include_recipe 'apt'

  package 'apt-transport-https'

  apt_repository 'gitlab-runner' do
    uri 'https://packages.gitlab.com/runner/gitlab-ci-multi-runner/' \
        "#{node['platform']}/"
    distribution node['lsb']['codename']
    components ['main']
    key 'https://packages.gitlab.com/gpg.key'
  end
when 'rhel'
  include_recipe 'yum'

  package 'pygpgme'

  yum_repository 'gitlab-runner' do
    description 'GitLab CI runner'
    baseurl 'https://packages.gitlab.com/runner/gitlab-ci-multi-runner/el/' \
            "#{node['platform_version'].split('.').first}/$basearch"
    gpgkey 'https://packages.gitlab.com/gpg.key'
    gpgcheck false
    options(repo_gpgcheck: true)
  end
end

package 'gitlab-ci-multi-runner'
