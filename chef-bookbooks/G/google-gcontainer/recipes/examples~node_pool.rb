# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by chef-codegen and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

# An example Chef recipe that creates a Google Cloud Computing DNS Managed Zone
# in a project.

# Defines a credential to be used when communicating with Google Cloud
# Platform. The title of this credential is then used as the 'credential'
# parameter in the gdns_project type.
#
# For more information on the gauth_credential parameters and providers please
# refer to its detailed documentation at:
#
# For the sake of this example we set the parameter 'path' to point to the file
# that contains your credential in JSON format. And for convenience this example
# allows a variable named $cred_path to be provided to it. If running from the
# command line you can pass it via the command line:
#
#   CRED_PATH=/path/to/my/cred.json \
#     chef-client -z --runlist \
#       "recipe[gcontainer::examples~node_pool]"
#
# For convenience you optionally can add it to your ~/.bash_profile (or the
# respective .profile settings) environment:
#
#   export CRED_PATH=/path/to/my/cred.json
#
# TODO(nelsonjr): Add link to documentation on Supermarket / Github
# ________________________

raise "Missing parameter 'CRED_PATH'. Please read docs at #{__FILE__}" \
  unless ENV.key?('CRED_PATH')

gauth_credential 'mycred' do
  action :serviceaccount
  path ENV['CRED_PATH'] # e.g. '/path/to/my_account.json'
  scopes [
    'https://www.googleapis.com/auth/cloud-platform'
  ]
end

raise "Missing parameter 'cluster_id'. Please read docs at #{__FILE__}" \
  unless ENV.key?('cluster_id')

gcontainer_cluster "mycluster-#{ENV['cluster_id']}" do
  action :create
  zone 'us-central1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end

gcontainer_node_pool 'web-servers' do
  action :create
  initial_node_count 4
  cluster "mycluster-#{ENV['cluster_id']}"
  zone 'us-central1-a'
  project 'google.com:graphite-playground'
  credential 'mycred'
end