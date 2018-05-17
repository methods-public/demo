if defined?(::ChefSpec)
  require 'chef/config'

  if ::Chef::Config[:pci_devices_disabled].nil?
    ::Chef::Log.warn '[PCI] Do not retrieve pci devices in ChefSpec context'
    ::Chef::Config[:pci_devices_disabled] = true
  end
end
