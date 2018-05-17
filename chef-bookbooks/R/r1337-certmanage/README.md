Chef Cookbook - Certificate Management
==============
This Chef cookbook will manage SSL certificates and keys through the use of Chef Vault.

Changes Performed
------------
1. Make sure `/data/ssl` as well as the `certs` and `keys` subdirectories are owned by root:root with 750 permissions
2. Deploy SSL certificates in both Apache and NginX (certificate + ca-bundle in one file) formats to `/data/ssl/certs`
3. Deploy SSL certificate keys to `/data/ssl/keys`
4. Removes any files from `/data/ssl`, `/data/ssl/certs`, and `/data/ssl/keys` that were not placed there by Chef

Requirements
------------
1. Chef (Tested on Chef 13.6.4)
2. Linux chef-clients (Tested on Ubuntu 14.04, Ubuntu 16.04, Ubuntu 18.04, and CentOS 7.2 but kitchen will let you test anything you want)
3. The chef-vault cookbook from Chef Supermarket
4. The managed_directory cookbook from Chef Supermarket

Installation Tips
------------

1. We personally use Berks to install this into Chef servers, because it will grab the dependencies for you as well.

Limitations
------------
1. None so far :)

Known Issues
------------
1. None so far :)

certificates Data Bag Format
------------

    {
        "id": "cert", # Unique name for the cert item in the vault.
        "fqdn": "www.route1337.com", # The cookbook will use this as part of the file name for the certificate and key
        "cert": "-----BEGIN CERTIFICATE-----\nMIIFQjC blah blah", # Certificate. REPLACE end lines with the literal characters "\n"
        "cabundle": "-----BEGIN CERTIFICATE-----\nMIIFQjC blah blah", # Certificate ca-bundle. REPLACE end lines with the literal characters "\n"
        "key": "-----BEGIN PRIVATE KEY-----\nMIIEwAIBA blah blah" # Certificate key. REPLACE end lines with the literal characters "\n"
    }

Use Cases
------------
Managing SSL certificates and keys in both Apache and NginX formats via the secure Chef Vault system.

Donate To Support This Chef Cookbook
------------
Route 1337, LLC operates entirely on donations. If you find this cookbook useful, please consider donating via one of these methods.

1. Bitcoin: 1CnzzrPh3iirEkLRLiWFKXDV9i5TXHQjE2
2. Bitcoin Cash: qzcq645swgd87s7t5mmmjcumf4armhtjt5euww5c29
3. Litecoin: LWYbc9hf5ErJsF874Q3wwmMiASHRWgwrjR
4. Ethereum: 0x117543aa7a4D704849171cA06568Ece71B111D18

Thank you for your support!

