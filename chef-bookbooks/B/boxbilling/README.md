BoxBilling Cookbook
===================
[![Cookbook Version](https://img.shields.io/cookbook/v/boxbilling.svg?style=flat)](https://supermarket.chef.io/cookbooks/boxbilling)
[![Dependency Status](http://img.shields.io/gemnasium/zuazo/boxbilling-cookbook.svg?style=flat)](https://gemnasium.com/zuazo/boxbilling-cookbook)
[![Code Climate](http://img.shields.io/codeclimate/github/zuazo/boxbilling-cookbook.svg?style=flat)](https://codeclimate.com/github/zuazo/boxbilling-cookbook)
[![Build Status](http://img.shields.io/travis/zuazo/boxbilling-cookbook/1.0.0.svg?style=flat)](https://travis-ci.org/zuazo/boxbilling-cookbook)

[Chef](https://www.chef.io/) cookbook to install and configure [BoxBilling](http://www.boxbilling.com/), invoice and client management software.

Requirements
============

## Supported Platforms

This cookbook has been tested on the following platforms:

* Amazon Linux
* CentOS `>= 6.0`
* Debian
* Fedora
* RedHat
* Ubuntu

Please, [let us know](https://github.com/zuazo/boxbilling-cookbook/issues/new?title=I%20have%20used%20it%20successfully%20on%20...) if you use it successfully on any other platform.

## Required Cookbooks

* [apache2](https://supermarket.chef.io/cookbooks/apache2)
* [cron](https://supermarket.chef.io/cookbooks/cron)
* [database](https://supermarket.chef.io/cookbooks/database)
* [encrypted_attributes (~> 0.2)](https://supermarket.chef.io/cookbooks/encrypted_attributes)
* [mysql (~> 5.0)](https://supermarket.chef.io/cookbooks/mysql)
* [openssl](https://supermarket.chef.io/cookbooks/openssl)
* [php](https://supermarket.chef.io/cookbooks/php)
* [ssl_certificate](https://supermarket.chef.io/cookbooks/ssl_certificate)
* [yum-epel](https://supermarket.chef.io/cookbooks/yum-epel)

## Required Applications

* Ruby `1.9.3` or higher.

Attributes
==========

| Attribute                                                    | Default                 | Description                    |
|:-------------------------------------------------------------|:------------------------|:-------------------------------|
| `node['boxbilling']['version']`                              | `'4.19.1'`              | BoxBilling version (See [below](#installing-boxbilling-3) for BoxBilling version `3` installation).
| `node['boxbilling']['download_url']`                         | *calculated*            | BoxBilling download URL.
| `node['boxbilling']['required_packages']`                    | `%w(unzip)`             | BoxBilling required packages.
| `node['boxbilling']['php_packages']`                         | *calculated*            | BoxBilling required PHP packages.
| `node['boxbilling']['dir']`                                  | `'/srv/www/boxbilling'` | BoxBilling installation directory.
| `node['boxbilling']['server_name']`                          | `node['fqdn']`          | BoxBilling server name.
| `node['boxbilling']['cron_enabled']`                         | `true`                  | Whether to enable BoxBilling cron job.
| `node['boxbilling']['headers']`                              | `{}`                    | BoxBilling HTTP headers to set as hash.
| `node['boxbilling']['ssl']`                                  | `true`                  | Whether to enable SSL in BoxBilling.
| `node['boxbilling']['encrypt_attributes']`                   | `false`                 | Whether to encrypt BoxBilling attributes containing credential secrets.
| `node['boxbilling']['web_server']`                           | `'apache'`              | Web server to use: `'apache'` or `'nginx'`
| `node['boxbilling']['admin']['email']`                       | *calculated*            | BoxBilling admin email.
| `node['boxbilling']['admin']['pass']`                        | *calculated*            | BoxBilling admin password.
| `node['boxbilling']['config']['timezone']`                   | `'America/New_York'`    | BoxBilling timezone. See [PHP supported timezones](http://php.net/manual/en/timezones.php).
| `node['boxbilling']['config']['db_host']`                    | `'localhost'`           | BoxBilling database host.
| `node['boxbilling']['config']['db_name']`                    | `'boxbilling'`          | BoxBilling database name.
| `node['boxbilling']['config']['db_user']`                    | `'boxbilling'`          | BoxBilling database user.
| `node['boxbilling']['config']['db_password']`                | *calculated*            | BoxBilling database user password.
| `node['boxbilling']['config']['url']`                        | *calculated*            | BoxBilling URL.
| `node['boxbilling']['config']['license']`                    | `nil`                   | BoxBilling license key (**required**). Go to [BoxBilling order page](http://www.boxbilling.com/order) to get a new license.
| `node['boxbilling']['config']['locale']`                     | `'en_US'`               | BoxBilling locale.
| `node['boxbilling']['config']['sef_urls']`                   | `false`                 | Whether to enable BoxBilling *search engine friendly* URLs.
| `node['boxbilling']['config']['debug']`                      | *calculated*            | Whether to enable BoxBilling debug mode.
| `node['boxbilling']['api_config']['require_referer_header']` | `true`                  | Whether to enable *require referer header* in the API.
| `node['boxbilling']['api_config']['allowed_ips']`            | `[]`                    | BoxBilling allowed IP addresses to access the API. Empty array will allow all IPs to access the API.
| `node['boxbilling']['api_config']['rate_span']`              | `3600`                  | BoxBilling API time span for limit in seconds.
| `node['boxbilling']['api_config']['rate_limit']`             | `1000`                  | BoxBilling API requests allowed per time span.
| `node['boxbilling']['mysql']['server_root_password']`        | *calculated*            | BoxBilling MySQL *root* password.
| `node['boxbilling']['mysql']['server_debian_password']`      | *calculated*            | BoxBilling MySQL *debian* user password.
| `node['boxbilling']['mysql']['server_repl_password']`        | *calculated*            | BoxBilling MySQL *repl* user password.

## The HTTPS Certificate

This cookbook uses the [`ssl_certificate`](https://supermarket.chef.io/cookbooks/ssl_certificate) cookbook to create the HTTPS certificate. The namespace used is `node['boxbilling']`. For example:

```ruby
node.default['boxbilling']['common_name'] = 'boxbilling.example.com'
node.default['boxbilling']['config']['license'] = '...' # BB_LICENSE key
include_recipe 'boxbilling'
```

See the [`ssl_certificate` namespace documentation](https://supermarket.chef.io/cookbooks/ssl_certificate#namespaces) for more information.

## Encrypted Attributes

This cookbook can use the [encrypted_attributes](https://supermarket.chef.io/cookbooks/encrypted_attributes) cookbook to encrypt the secrets generated during the *Chef Run*. This feature is disabled by default, but can be enabled setting the `node['boxbilling']['encrypt_attributes']` attribute to `true`. For example:

```ruby
include_recipe 'encrypted_attributes::users_data_bag'
node.default['boxbilling']['encrypt_attributes'] = true
node.default['boxbilling']['config']['license'] = '...' # BB_LICENSE key
inclure_recipe 'boxbilling'
```

This will create the following encrypted attributes:

* `node['boxbilling']['admin']['pass']`: BoxBilling admin password.
* `node['boxbilling']['mysql']['root']`: MySQL *root* user password.
* `node['boxbilling']['mysql']['debian']`: MySQL *debian* user password.
* `node['boxbilling']['mysql']['repl']`: MySQL *repl* user password.
* `node['boxbilling']['config']['db_password']`: MySQL BoxBilling user password.

Read the [`chef-encrypted-attributes` gem documentation](http://onddo.github.io/chef-encrypted-attributes/) to learn how to read them.

Recipes
=======

## boxbilling::default

Installs and configures BoxBilling. Including the MySQL server if set to localhost.

## boxbilling::api

Installs the requirementes to use the `boxbilling_api` resource.

## boxbilling::mysql

Installs MySQL server for BoxBilling.

Resources
=========

## boxbilling_api[path]

This resource uses the [BoxBilling v2 Admin API](http://www.boxbilling.com/docs/api-admin.html) with some modifications:

* Some paths has been normalized, the action has been removed from the path and the resource action is issued instead.
* The *update* action is simulated for some objects that do not support it, using *delete* and *create*.
* All the action names has been simplified to *create*, *update* and *delete*.

**Note:** Keep in mind that some API calls require self-generated/auto-incremented MySQL identifiers. So their use can become difficult sometimes.

## boxbilling_api Actions

* `request` (*default*): Sends a HTTP raw API request.
* `create`: Sends a create action to the API object.
* `update`: Sends an update action to the API object.
* `delete`: Send a delete action to the API object.

## boxbilling_api Parameters

| Parameter      | Default      | Description                    |
|:---------------|:-------------|:-------------------------------|
| path           | *name*       | BoxBilling API relative path. For example: `'admin/product'`.
| data           | `{}`         | Data to send as hash.
| debug          | *calculated* | Whether to enable debug mode.
| ignore_failure | `false`      | Ignore API HTTP errors.

Usage
=====

You need a valid BoxBilling license key to use this cookbook. You can get a new license in the [BoxBilling order page](http://www.boxbilling.com/order).

## Including in a Cookbook Recipe

You can simply include it in a recipe:

```ruby
# in your recipe
node.default['boxbilling']['config']['license'] = '...' # BB_LICENSE key
include_recipe 'boxbilling'
```

Don't forget to include the `boxbilling` cookbook as a dependency in the metadata:

```ruby
# metadata.rb
depends 'boxbilling'
```

## Including in the Run List

Another alternative is to include it in your *Run List*:

```json
{
  "name": "client.example.com",
  "[...]": "[...]",
  "normal": {
    "boxbilling": {
      "config": {
        "license": "BB_LICENSE"
      }
    }
  },
  "run_list": [
    "[...]",
    "recipe[boxbilling]"
  ]
}
```

## Installing BoxBilling 3

To install BoxBilling version `3`, you must change the `node['boxbilling']['download_url']` attribute.

You can use GitHub to download the release. For example:

```ruby
node.default['boxbilling']['config']['license'] = '...' # BB_LICENSE key
node.default['boxbilling']['download_url'] = 'http://files.zuazo.org/boxbilling-3.6.11.zip'

include_recipe 'boxbilling::default'
```

## *boxbilling::default* Recipe Usage Example

```ruby
node.default['boxbilling']['config']['license'] = '...' # BB_LICENSE key
include_recipe 'boxbilling::default'
```

## *boxbilling::api* Recipe Usage Example

```ruby
include_recipe 'boxbilling::api'
```

## *boxbilling::mysql* Recipe Usage Example

```ruby
include_recipe 'boxbilling::mysql'
```

## *boxbilling_api* Resource Usage Example

Below is a fairly complete real example:

```ruby
# =============================================================================
# Products
# =============================================================================

# Disable "Domains registration and transfer" product
boxbilling_api 'admin/product Domains registration and transfer' do
  path 'admin/product'
  data(
    id: 1,
    status: 'disabled'
  )
  action :update
end

# =============================================================================
# News
# =============================================================================

# Delete some default blog news
(1..3).each do |id|
  boxbilling_api "admin/news delete #{id}" do
    path 'admin/news'
    data id: id
    action :delete
  end
end

# New blog post
# boxbilling_api 'admin/news' do
#   data(
#     id: 4,
#     content: 'Blog post content...',
#     title: 'My first blog post',
#     # image: 'http://www.yourdomain.com/image.jpg',
#     status: 'active'
#     # created_at: '2012-01-01',
#     # updated_at: '2012-01-01'
#   )
#   action :create
# end

# =============================================================================
# Knowledge Base
# =============================================================================

# Disable some default articles
(1..3).each do |id|
  boxbilling_api 'admin/kb/article #{id}' do
    path 'admin/kb/article'
    data(
      id: id,
      status: 'draft'
    )
    action :update
  end
end

# Create some categories
# boxbilling_api 'admin/kb/category 3' do
#   path 'admin/kb/category'
#   data(
#     id: 3,
#     title: 'New KB category',
#     description: 'New KB category content description'
#   )
#   action :create
# end

# Add some articles
# boxbilling_api 'admin/kb/article 4' do
#   path 'admin/kb/article'
#   data(
#     id: 4,
#     kb_article_category_id: 3,
#     title: 'My New Article',
#     status: 'active',
#     content: 'My article content...'
#   )
#   action :create
# end

# =============================================================================
# Configuration > Settings > Client
# =============================================================================

boxbilling_api 'admin/extension/config' do
  data(
    ext: 'mod_client',
    allow_signup: 1,
    require_email_confirmation: 1,
    allow_change_email: 1,
    required: %w(last_name country city state address_1 postcode phone)
  )
  action :update
end

# =============================================================================
# Configuration > Settings > Currency settings
# =============================================================================

boxbilling_api 'admin/currency EUR' do
  path 'admin/currency'
  data(
    code: 'EUR',
    title: 'Euro',
    format: "{{price}} \u20AC"
  )
  action :create
end

boxbilling_api 'admin/currency GBP' do
  path 'admin/currency'
  data(
    code: 'GBP',
    title: 'Pound Sterling',
    format: "\u00A3{{price}}"
  )
  action :create
end

boxbilling_api 'admin/currency/set_default' do
  data code: 'EUR'
end

# =============================================================================
# Configuration > Settings > Email
# =============================================================================

boxbilling_api 'admin/email/batch_template_generate'

# Reset a template
# boxbilling_api 'admin/email/template_reset client_password_reset_approve' do
#   path 'admin/email/template_reset'
#   data code: 'mod_client_password_reset_approve'
# end

# Create a new template
# boxbilling_api 'admin/email/template 1' do
#   path 'admin/email/template'
#   data(
#     id: 1,
#     enabled: 1,
#     category: 'client',
#     action_code: 'mod_client_password_reset_approve',
#     subject: '[{{ guest.system_company.name }}] Password Changed',
#     content: '...'
#   )
#   action :create
# end

# Update an existing template
# boxbilling_api 'admin/email/template 1' do
#   path 'admin/email/template'
#   data(
#     id: 1,
#     enabled: 1,
#     subject: '[{{ guest.system_company.name }}] Password Changed',
#     content: <<-EOF
# {% filter markdown %}
# 
# Dear {{ c.first_name }} {{ c.last_name }},
# 
# As you requested, your password for our client area has now been reset.
# Your new login details are as follows:
# 
# Login at: {{"login"|link}}?email={{ c.email }}
# Email: {{ c.email }}
# Password: {{ password }}
# 
# To change your password to something more memorable, after logging in go to 
# Profile &gt; Change Password.
# 
# Edit your profile at {{ "me"|link }}
# 
# {{ guest.system_company.signature }}
# 
# {% endfilter %}
#     EOF
#   )
#   action :update
# end

# Email settings
# boxbilling_api 'admin/extension/config mod_email' do
#   path 'admin/extension/config'
#   data(
#     ext: 'mod_email',
#     log_enabled: 1,
#     mailer: 'smtp', # sendmail | smtp
#     smtp_host: smtp_host,
#     smtp_port: 587,
#     smtp_username: smtp_username,
#     smtp_password: smtp_password,
#     smtp_security: 'tls',
#   )
#   action :update
# end

# =============================================================================
# Configuration > Settings > Invoice settings
# =============================================================================

# Set next invoice number
# IMPORTANT: this must be run only once, will cause duplicated invoice numbers
boxbilling_api 'admin/system/params invoice starting_number' do
  path 'admin/system/params'
  data invoice_starting_number: '1'
  action :nothing
end

boxbilling_api 'admin/system/params invoice settings' do
  path 'admin/system/params'
  data(
    invoice_issue_days_before_expire: 14,
    invoice_due_days: 5,
    invoice_auto_approval: 1,
    remove_after_days: 0,
    invoice_series: 'PRO-N',
    invoice_series_paid: 'N',
    # negative_invoice | credit_note | manual
    invoice_refund_logic: 'credit_note',
    funds_min_amount: 10,
    funds_max_amount: 200
  )
  action :update
  notifies :update, 'boxbilling_api[admin/system/params invoice starting_number]'
end

# =============================================================================
# Configuration > Settings > Orders settings
# =============================================================================

boxbilling_api 'admin/extension/config mod_order' do
  path 'admin/extension/config'
  data(
    ext: 'mod_order',
    # from_expiration_date | from_today | from_greater
    order_renewal_logic: 'from_expiration_date',
    batch_suspend_reason: ''
  )
  action :update
end

# =============================================================================
# Configuration > Settings > System settings
# =============================================================================

boxbilling_api 'admin/system/params system settings' do
  path 'admin/system/params'
  data(
    company_name: 'Testing Labs, Ltd',
    company_logo: '',
    company_email: 'testing@testing.com',
    company_tel: '1234567890',
    company_address_1: 'Somewhere',
    company_number: 'B12345678',
    company_vat_number: 'EU12345678',
    company_account_number: 'BANK-1234',
    company_signature: 'Testing signature'
  )
  action :update
end

# =============================================================================
# Configuration > Domain registration/management
# =============================================================================

# Delete default domain TLD
boxbilling_api 'admin/servicedomain/tld' do
  data tld: '.com'
  action :delete
end

# =============================================================================
# Configuration > Payment gateways
# =============================================================================

boxbilling_api 'admin/invoice/gateway Custom' do
  path 'admin/invoice/gateway'
  data(
    id: 1,
    enabled: 0,
    test_mode: 0
  )
  action :update
end

# boxbilling_api 'admin/invoice/gateway PayPal' do
#   path 'admin/invoice/gateway'
#   data(
#     id: 2,
#     enabled: 1,
#     config: {
#       email: paypal_email
#     },
#     accepted_currencies: %w(EUR USD GBP),
#     test_mode: 0
#   )
#   action :update
# end

boxbilling_api 'admin/invoice/gateway AlertPay' do
  path 'admin/invoice/gateway'
  data(
    id: 3,
    enabled: 0,
    test_mode: test_mode
  )
  action :update
end

# =============================================================================
# Configuration > Tax
# =============================================================================

# Enable taxes
boxbilling_api 'admin/system/params taxes' do
  path 'admin/system/params'
  data tax_enabled: 1
  action :update
end

# It deletes all the taxes and regenerate them instead of checking if they
# previously exists. Notified by boxbilling_api[admin/invoice/tax]
boxbilling_api 'admin/invoice/tax_setup_eu' do
  data(
    name: 'VAT EU12345678',
    taxrate: 21
  )
  action :nothing
end

boxbilling_api 'admin/invoice/tax' do
  data(
    id: 9, # important, must match tax id when usign auto generated/increment
    name: 'EU12345678',
    taxrate: 21,
    country: 'ES'
  )
  action :create
  notifies :request, 'boxbilling_api[admin/invoice/tax_setup_eu]'
end
```

Testing
=======

See [TESTING.md](https://github.com/zuazo/boxbilling-cookbook/blob/master/TESTING.md).

## ChefSpec Matchers

### boxbilling_api(path)

Helper method for locating a `boxbilling_api` resource in the collection.

```ruby
resource = chef_run.boxbilling_api('admin/system/params')
expect(resource)
  .to notify('boxbilling_api[admin/system/params invoice starting_number]')
  .to(:update).delayed
```

### request_boxbilling_api(path)

Assert that the *Chef Run* makes a `boxbilling_api` request.

```ruby
expect(chef_run).to request_boxbilling_api(path)
```

### create_boxbilling_api(path)

Assert that the *Chef Run* makes a `boxbilling_api` create request.

```ruby
expect(chef_run).to create_boxbilling_api(path)
```

### update_boxbilling_api(path)

Assert that the *Chef Run* makes a `boxbilling_api` update request.

```ruby
expect(chef_run).to update_boxbilling_api(path)
```

### delete_boxbilling_api(path)

Assert that the *Chef Run* makes a `boxbilling_api` delete request.

```ruby
expect(chef_run).to delete_boxbilling_api(path)
```

Contributing
============

Please do not hesitate to [open an issue](https://github.com/zuazo/boxbilling-cookbook/issues/new) with any questions or problems.

See [CONTRIBUTING.md](https://github.com/zuazo/boxbilling-cookbook/blob/master/CONTRIBUTING.md).

TODO
====

See [TODO.md](https://github.com/zuazo/boxbilling-cookbook/blob/master/TODO.md).


License and Author
==================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | [Raul Rodriguez](https://github.com/raulr) (<raul@onddo.com>)
| **Author:**          | [Xabier de Zuazo](https://github.com/zuazo) (<xabier@zuazo.org>)
| **Copyright:**       | Copyright (c) 2015, Xabier de Zuazo
| **Copyright:**       | Copyright (c) 2013-2015, Onddo Labs, SL.
| **License:**         | Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
