google-cloud-logging Cookbook
================
This cookbook installs package for Google Cloud Logging and starts the agent (google-fluentd).

 This cookbook does the following:

   1. Configures the required apt or yum repository.
      The environment variable REPO_SUFFIX can be set to alter which
      repository is used.  A dash (-) will be inserted prior to the supplied
      suffix. Example values are 'unstable' or '20151027-1'.
   2. Installs the logging agent.
   3. Installs "catch-all" configuration files (unless the environment
      variable DO_NOT_INSTALL_CATCH_ALL_CONFIG is set to suppress this.)
   4. Starts the logging agent.
   5. Sends a test message which should be visible in the log viewer.

Google Cloud Logging collects and stores logs from applications and services on the Google Cloud Platform:

   * View your logs with the Logs Viewer, including third-party logs from your virtual machine instances.
   * Export your logs to Google Cloud Storage, Google BigQuery, or Google Cloud Pub/Sub.
   * Create logs-based metrics to use for monitoring and alerting in Google Cloud Monitoring.
   * Get immutable audit logs for auditing and compliance.
   * Use the Cloud Logging API to read, write, and configure logs.


Requirements
------------

### Platform
The platforms supported are Amazon Linux, Debian/Ubuntu, Redhat/CentOS

### Packages
The cookbook uses default package managers for the platform

Attributes
----------
None

License and Authors
-------------------
Authors: Vipin Thomas, Karthik Subramanian
