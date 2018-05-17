#
# Cookbook Name:: hipchat_client
# Attributes:: default
#

if node['os'] == 'linux'
  default['hipchat_client']['baseurl']      = 'https://atlassian.artifactoryonline.com/atlassian/hipchat-yum-client'
  default['hipchat_client']['description']  = 'Atlassian Hipchat'
  default['hipchat_client']['key']          = 'https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public'
  default['hipchat_client']['repo_name']    = 'atlassian-hipchat'
  default['hipchat_client']['uri']          = 'https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client'
end
