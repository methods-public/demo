#
# Cookbook:: yum_repositories
# Recipe:: default
#

def manage_repo(
    repo,
    name_opt,
    baseurl_opt,
    cost_opt,
    clean_headers_opt,
    clean_metadata_opt,
    description_opt,
    enabled_opt,
    enablegroups_opt,
    exclude_opt,
    failovermethod_opt,
    fastestmirror_opt,
    gpgcheck_opt,
    gpgkey_opt,
    http_caching_opt,
    include_config_opt,
    includepkgs_opt,
    keepalive_opt,
    make_cache_opt,
    max_retries_opt,
    metadata_expire_opt,
    mirrorexpire_opt,
    mirrorlist_opt,
    mirror_expire_opt,
    mirrorlist_expireOpt,
    options_opt,
    priority_opt,
    proxy_opt,
    proxy_username_opt,
    proxy_password_opt,
    username_opt,
    password_opt,
    repo_gpgcheck_opt,
    report_instanceidOpt,
    repositoryid_opt,
    sensitive_opt,
    skip_if_unavil_opt,
    source_opt,
    sslcacert_opt,
    sslclientcert_opt,
    sslclientkey_opt,
    sslverify_opt,
    timeout_opt,
    action_opt
)

  yum_repository repo do

    if name_opt
      name name_opt
    else
      name repo
    end

    if baseurl_opt
      baseurl baseurl_opt
    end

    if cost_opt
      cost cost_opt
    end

    unless clean_headers_opt.nil?
      clean_headers clean_headers_opt
    end

    unless clean_metadata_opt.nil?
      clean_metadata clean_metadata_opt
    end

    if description_opt
      description description_opt
    end

    unless enabled_opt.nil?
      enabled enabled_opt
    end

    unless enablegroups_opt.nil?
      enablegroups enablegroups_opt
    end

    if exclude_opt
      exclude exclude_opt
    end

    if failovermethod_opt
      failovermethod failovermethod_opt
    end

    unless fastestmirror_opt.nil?
      fastestmirror_enabled fastestmirror_opt
    end

    unless gpgcheck_opt.nil?
      gpgcheck gpgcheck_opt
    end

    if gpgkey_opt
      gpgkey gpgkey_opt
    end

    if http_caching_opt
      http_caching http_caching_opt
    end

    if include_config_opt
      include_config include_config_opt
    end

    if includepkgs_opt
      includepkgs includepkgs_opt
    end

    unless keepalive_opt.nil?
      keepalive keepalive_opt
    end

    unless make_cache_opt.nil?
      make_cache make_cache_opt
    end

    if max_retries_opt
      max_retries max_retries_opt
    end

    if metadata_expire_opt
      metadata_expire metadata_expire_opt
    end

    if mirrorexpire_opt
      mirrorexpire mirrorexpire_opt
    end

    if mirrorlist_opt
      mirrorlist mirrorlist_opt
    end

    if mirror_expire_opt
      mirror_expire mirror_expire_opt
    end

    if mirrorlist_expire
      mirrorlist_expire mirrorlist_expireOpt
    end

    if options_opt
      options options_opt
    end

    if priority_opt
      priority priority_opt
    end

    if proxy_opt
      proxy proxy_opt
    end

    if proxy_username_opt
      proxy_username proxy_username_opt
    end

    if proxy_password_opt
      proxy_password proxy_password_opt
    end

    if username_opt
      username username_opt
    end

    if password_opt
      password password_opt
    end

    unless repo_gpgcheck_opt.nil?
      repo_gpgcheck repo_gpgcheck_opt
    end

    unless report_instanceid.nil?
      report_instanceid report_instanceidOpt
    end

    if repositoryid_opt
      repositoryid repositoryid_opt
    end

    unless sensitive_opt.nil?
      sensitive sensitive_opt
    end

    if skip_if_unavil_opt.nil?
      skip_if_unavailable skip_if_unavil_opt
    end

    if source_opt
      source source_opt
    end

    if sslcacert_opt
      sslcacert sslcacert_opt
    end

    if sslclientcert_opt
      sslclientcert sslclientcert_opt
    end

    if sslclientkey_opt
      sslclientkey sslclientkey_opt
    end

    unless sslverify_opt.nil?
      sslverify sslverify_opt
    end

    if timeout_opt
      timeout timeout_opt
    end

    if action_opt
      action action_opt
    end
  end

end

unless node['yum_repositories']['ignore_failures'].nil?
  ignore_fail_option = node['yum_repositories']['ignore_failures']
end

if node['yum_repositories']['repositories']
  node['yum_repositories']['repositories'].each do |repo, repo_options|

    unless repo_options['ignore_failures'].nil?
      ignore_fail_option = repo_options['ignore_failures']
    end

    name_opt = repo
    if repo_options['name']
      name_opt = repo_options['name']
    end

    baseurl_opt = false
    if repo_options['baseurl']
      baseurl_opt = repo_options['baseurl']
    end

    cost_opt = false
    if repo_options['cost']
      cost_opt = repo_options['cost']
    end

    clean_headers_opt = nil
    unless repo_options['clean_headers'].nil?
      clean_headers_opt = repo_options['clean_headers']
    end

    clean_metadata_opt = nil
    unless repo_options['clean_metadata'].nil?
      clean_metadata_opt = repo_options['clean_metadata']
    end

    description_opt = false
    if repo_options['description']
      description_opt = repo_options['description']
    end

    enabled_opt = nil
    unless repo_options['enabled'].nil?
      enabled_opt = repo_options['enabled']
    end

    enablegroups_opt = nil
    unless repo_options['enablegroups'].nil?
      enablegroups_opt = repo_options['enablegroups']
    end

    exclude_opt = false
    if repo_options['exclude']
      exclude_opt = repo_options['exclude_opt']
    end

    failovermethod_opt = false
    if repo_options['failovermethod']
      failovermethod_opt = repo_options['failovermethod']
    end

    fastestmirror_opt = nil
    unless repo_options['fastestmirror_enabled'].nil?
      fastestmirror_opt = repo_options['fastestmirror_enabled']
    end

    gpgcheck_opt = nil
    unless repo_options['gpgcheck'].nil?
      gpgcheck_opt = repo_options['gpgcheck']
    end

    gpgkey_opt = false
    if repo_options['gpgkey']
      gpgkey_opt = repo_options['gpgkey']
    end

    http_caching_opt = false
    if repo_options['http_caching']
      http_caching_opt = repo_options['http_caching']
    end

    include_config_opt = false
    if repo_options['include_config']
      include_config_opt = repo_options['include_config']
    end

    includepkgs_opt = false
    if repo_options['includepkgs']
      includepkgs_opt = repo_options['includepkgs']
    end

    keepalive_opt = nil
    unless repo_options['keepalive'].nil?
      keepalive_opt = repo_options['keepalive']
    end

    make_cache_opt = nil
    unless repo_options['make_cache'].nil?
      make_cache_opt = repo_options['make_cache']
    end

    max_retries_opt = false
    if repo_options['max_retries']
      max_retries_opt = repo_options['max_retries']
    end

    metadata_expire_opt = false
    if repo_options['metadata_expire']
      metadata_expire_opt = repo_options['metadata_expire']
    end

    mirrorexpire_opt = false
    if repo_options['mirrorexpire']
      mirrorexpire_opt = repo_options['mirrorexpire']
    end

    mirrorlist_opt = false
    if repo_options['mirrorlist']
      mirrorlist_opt = repo_options['mirrorlist']
    end

    mirror_expire_opt = false
    if repo_options['mirror_expire']
      mirror_expire_opt = repo_options['mirror_expire']
    end

    mirrorlist_expireOpt = false
    if repo_options['mirrorlist_expire']
      mirrorlist_expireOpt = repo_options['mirrorlist_expire']
    end

    options_opt = false
    if repo_options['options']
      if repo_options['options'].kind_of?(Array)
        options_opt = {}
        repo_options['options'].each do |key, value|
          options_opt[key.to_sym] = value
        end
      elsif repo_options['options'].kind_of?(Hash)
        options_opt = repo_options['options']
      else
        options_opt = false
      end
    end

    priority_opt = false
    if repo_options['priority']
      priority_opt = repo_options['priority']
    end

    proxy_opt = false
    if repo_options['proxy']
      proxy_opt = repo_options['proxy']
    end

    proxy_username_opt = false
    if repo_options['proxy_username']
      proxy_username_opt = repo_options['proxy_username']
    end

    proxy_password_opt = false
    if repo_options['proxy_password']
      proxy_password_opt = repo_options['proxy_password']
    end

    username_opt = false
    if repo_options['username']
      username_opt = repo_options['username']
    end

    password_opt = false
    if repo_options['password']
      password_opt = repo_options['password']
    end

    repo_gpgcheck_opt = nil
    unless repo_options['repo_gpgcheck'].nil?
      repo_gpgcheck_opt = repo_options['repo_gpgcheck']
    end

    report_instanceidOpt = nil
    unless repo_options['report_instanceid'].nil?
      report_instanceidOpt = repo_options['report_instanceid']
    end

    repositoryid_opt = false
    if repo_options['repositoryid']
      repositoryid_opt = repo_options['repositoryid']
    end

    sensitive_opt = nil
    unless repo_options['sensitive'].nil?
      sensitive_opt = repo_options['sensitive']
    end

    skip_if_unavil_opt = nil
    unless repo_options['skip_if_unavailable'].nil?
      skip_if_unavil_opt = repo_options['skip_if_unavailable']
    end

    source_opt = false
    if repo_options['source']
      source_opt = repo_options['source']
    end

    sslcacert_opt = false
    if repo_options['sslcacert']
      sslcacert_opt = repo_options['sslcacert']
    end

    sslclientcert_opt = false
    if repo_options['sslclientcert']
      sslclientcert_opt = repo_options['sslclientcert']
    end

    sslclientkey_opt = false
    if repo_options['sslclientkey']
      sslclientkey_opt = repo_options['sslclientkey']
    end

    sslverify_opt = nil
    unless repo_options['sslverify'].nil?
      sslverify_opt = repo_options['sslverify']
    end

    timeout_opt = false
    if repo_options['timeout']
      timeout_opt = repo_options['timeout']
    end

    action_opt = :create
    if repo_options['action']
      case repo_options['action'].downcase
        when 'create'
          action_opt = :create
        when 'add'
          action_opt = :create
        when 'delete'
          action_opt = :delete
        when 'remove'
          action_opt = :delete
        when 'makecache'
          action_opt = :makecache
        else
          log 'yum_repositories' do
            message "The repo: '#{repo}' contains a malformed or unknown action (#{action})... ignoring it and skipping the repo!"
            level :warn
            next
          end
      end
    end

    if ignore_fail_option

      begin
        manage_repo(
            repo,
            name_opt,
            baseurl_opt,
            cost_opt,
            clean_headers_opt,
            clean_metadata_opt,
            description_opt,
            enabled_opt,
            enablegroups_opt,
            exclude_opt,
            failovermethod_opt,
            fastestmirror_opt,
            gpgcheck_opt,
            gpgkey_opt,
            http_caching_opt,
            include_config_opt,
            includepkgs_opt,
            keepalive_opt,
            make_cache_opt,
            max_retries_opt,
            metadata_expire_opt,
            mirrorexpire_opt,
            mirrorlist_opt,
            mirror_expire_opt,
            mirrorlist_expireOpt,
            options_opt,
            priority_opt,
            proxy_opt,
            proxy_username_opt,
            proxy_password_opt,
            username_opt,
            password_opt,
            repo_gpgcheck_opt,
            report_instanceidOpt,
            repositoryid_opt,
            sensitive_opt,
            skip_if_unavil_opt,
            source_opt,
            sslcacert_opt,
            sslclientcert_opt,
            sslclientkey_opt,
            sslverify_opt,
            timeout_opt,
            action_opt
        )
      rescue
        log 'yum_repositories' do
          message "There was an error while processing repo: '#{repo}' skipping the repo!"
          level :warn
          next
        end
      end

    else
      manage_repo(
          repo,
          name_opt,
          baseurl_opt,
          cost_opt,
          clean_headers_opt,
          clean_metadata_opt,
          description_opt,
          enabled_opt,
          enablegroups_opt,
          exclude_opt,
          failovermethod_opt,
          fastestmirror_opt,
          gpgcheck_opt,
          gpgkey_opt,
          http_caching_opt,
          include_config_opt,
          includepkgs_opt,
          keepalive_opt,
          make_cache_opt,
          max_retries_opt,
          metadata_expire_opt,
          mirrorexpire_opt,
          mirrorlist_opt,
          mirror_expire_opt,
          mirrorlist_expireOpt,
          options_opt,
          priority_opt,
          proxy_opt,
          proxy_username_opt,
          proxy_password_opt,
          username_opt,
          password_opt,
          repo_gpgcheck_opt,
          report_instanceidOpt,
          repositoryid_opt,
          sensitive_opt,
          skip_if_unavil_opt,
          source_opt,
          sslcacert_opt,
          sslclientcert_opt,
          sslclientkey_opt,
          sslverify_opt,
          timeout_opt,
          action_opt
      )
    end
  end
else
  log 'yum_repositories' do
    message "No repositories defined"
    level :warn
  end
end