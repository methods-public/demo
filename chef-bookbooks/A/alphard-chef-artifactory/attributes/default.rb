#
# Cookbook Name:: alphard-chef-artifactory
# Attributes:: default
#
# Copyright 2016, Hydra Technologies, Inc
#
# All rights reserved - Do Not Redistribute
#

# Install
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['oracle']['accept_oracle_download_terms'] = true
default['alphard']['artifactory']['user'] = 'root'
default['alphard']['artifactory']['group'] = 'root'
default['alphard']['artifactory']['home'] = '/opt/jfrog/artifactory'
default['alphard']['artifactory']['version'] = '4.12.2'
default['alphard']['artifactory']['fqdn'] = 'artloc.sportagraph.com'
default['alphard']['artifactory']['configuration_template_file'] = 'artifactory.config.xml.erb'

# Apache2
default['apache']['listen'] = %w(*:80 *:8080)
default['alphard']['artifactory']['apache2']['file'] = 'artifactory.conf.erb'
default['alphard']['artifactory']['apache2']['fqdn'] = 'artifactory'
default['alphard']['artifactory']['apache2']['port'] = 8080
default['alphard']['artifactory']['apache2']['email'] = 'artifactory@mydomain.com'

# General Config
default['alphard']['artifactory']['serverName'] = ''
default['alphard']['artifactory']['offlineMode'] = false
default['alphard']['artifactory']['helpLinksEnabled'] = true
default['alphard']['artifactory']['fileUploadMaxSizeMb'] = 100
default['alphard']['artifactory']['dateFormat'] = 'dd-MM-yy HH:mm:ss z'

# Security
default['alphard']['artifactory']['security']['anonAccessEnabled'] = false
default['alphard']['artifactory']['security']['anonAccessToBuildInfosDisabled'] = false
default['alphard']['artifactory']['security']['hideUnauthorizedResources'] = true

default['alphard']['artifactory']['security']['passwordSettings']['encryptionPolicy'] = 'supported'
default['alphard']['artifactory']['security']['passwordSettings']['expirationPolicy']['enabled'] = false
default['alphard']['artifactory']['security']['passwordSettings']['expirationPolicy']['passwordMaxAge'] = 60
default['alphard']['artifactory']['security']['passwordSettings']['expirationPolicy']['notifyByEmail'] = true

default['alphard']['artifactory']['security']['userLockPolicy']['enabled'] = false
default['alphard']['artifactory']['security']['userLockPolicy']['loginAttempts'] = 3

# Backup
default['alphard']['artifactory']['backups'] = {
  'backup-daily' => {
    # backup Monday to Friday at 2:00 AM
    cronExp: '0 0 2 ? * MON-FRI',
    # Always backup to a "current" dir (incremental backups)
    retentionPeriodHours: 0,
    excludedRepositories: %w(jcenter)
  },
  'backup-weekly' => {
    # backup on Saturday at 2:00 AM
    cronExp: '0 0 2 ? * SAT',
    # keep backups for 2 weeks.
    retentionPeriodHours: 336,
    excludedRepositories: %w(jcenter)
  }
}

# Indexer
default['alphard']['artifactory']['indexer']['cronExp'] = '0 23 5 * * ?' # By Default index once a day at 05:23AM

# Local repositories
default['alphard']['artifactory']['localRepositories'] = {
  'libs-release-local' => {
    type: 'maven',
    description: 'Local repository for in-house libraries',
    repoLayoutRef: 'maven-2-default',
    handleReleases: true,
    handleSnapshots: false,
    suppressPomConsistencyChecks: false
  },
  'libs-snapshot-local' => {
    type: 'maven',
    description: 'Local repository for in-house libraries snapshots',
    repoLayoutRef: 'maven-2-default',
    handleReleases: false,
    handleSnapshots: true,
    suppressPomConsistencyChecks: false
  },
  'plugins-release-local' => {
    type:  'maven',
    description: 'Local repository for plugins',
    repoLayoutRef: 'maven-2-default',
    handleReleases: true,
    handleSnapshots: false,
    suppressPomConsistencyChecks: false
  },
  'plugins-snapshot-local' => {
    type: 'maven',
    description: 'Local repository for plugins snapshots',
    repoLayoutRef: 'maven-2-default',
    handleReleases: false,
    handleSnapshots: true,
    suppressPomConsistencyChecks: false
  },
  'ext-release-local' => {
    type: 'maven',
    description: 'Local repository for third party libraries',
    repoLayoutRef: 'maven-2-default',
    handleReleases: true,
    handleSnapshots: false,
    suppressPomConsistencyChecks: false
  },
  'ext-snapshot-local' => {
    type: 'maven',
    description: 'Local repository for third party libraries snapshots',
    repoLayoutRef: 'maven-2-default',
    handleReleases: false,
    handleSnapshots: true,
    suppressPomConsistencyChecks: false
  }
}

# Remote repositories
default['alphard']['artifactory']['remoteRepositories'] = {
  'jcenter' => {
    type: 'maven',
    description: 'Bintray Central Java repository',
    repoLayoutRef: 'maven-2-default',
    handleReleases: true,
    handleSnapshots: false,
    suppressPomConsistencyChecks: false,
    url: 'http://jcenter.bintray.com',
    blockMismatchingMimeTypes: true
  }
}

# Virtual repositories
default['alphard']['artifactory']['virtualRepositories'] = {
  'remote-repos' => {
    type: 'maven',
    artifactoryRequestsCanRetrieveRemoteArtifacts: true,
    repositories: %w(jcenter)
  },
  'libs-release' => {
    type: 'maven',
    repositories: %w(libs-release-local ext-release-local remote-repos)
  },
  'plugins-release' => {
    type: 'maven',
    repositories: %w(plugins-release-local ext-release-local remote-repos)
  },
  'libs-snapshot' => {
    type: 'maven',
    repositories: %w(libs-snapshot-local ext-snapshot-local remote-repos)
  },
  'plugins-snapshot' => {
    type: 'maven',
    repositories: %w(plugins-snapshot-local ext-snapshot-local remote-repos)
  }
}

# Base URL
default['alphard']['artifactory']['urlBase'] = ''

# Logo
default['alphard']['artifactory']['logo'] = ''

# Footer
default['alphard']['artifactory']['footer'] = ''

# GC Config
default['alphard']['artifactory']['gcConfig']['cronExp'] = '0 0 /4 * * ?'

# Cleanup Config
default['alphard']['artifactory']['cleanupConfig']['cronExp'] = '0 12 5 * * ?' # by default cleanup once a day at 05:12AM

# Virtual Cache Cleanup Config
default['alphard']['artifactory']['virtualCacheCleanupConfig']['cronExp'] = '0 12 0 * * ?' # by default cleanup once a day at 05:00AM

# Folder Download Config
default['alphard']['artifactory']['folderDownloadConfig']['enabled'] = false
default['alphard']['artifactory']['folderDownloadConfig']['maxDownloadSizeMb'] = 1024
default['alphard']['artifactory']['folderDownloadConfig']['maxFiles'] = 5000
default['alphard']['artifactory']['folderDownloadConfig']['maxConcurrentRequests'] = 10

# System Message Config
default['alphard']['artifactory']['systemMessageConfig']['enabled'] = false
default['alphard']['artifactory']['systemMessageConfig']['title'] = ''
default['alphard']['artifactory']['systemMessageConfig']['titleColor'] = '#429F46'
default['alphard']['artifactory']['systemMessageConfig']['message'] = ''
default['alphard']['artifactory']['systemMessageConfig']['showOnAllPages'] = false

# Trash Can Config
default['alphard']['artifactory']['trashcanConfig']['enabled'] = true
default['alphard']['artifactory']['trashcanConfig']['allowPermDeletes'] = false
default['alphard']['artifactory']['trashcanConfig']['retentionPeriodDays'] = 14
