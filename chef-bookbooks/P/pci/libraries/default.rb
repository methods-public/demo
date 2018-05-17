require_relative 'linux.rb'
require_relative 'windows.rb'

# Provides methods to fetch PCI information
module PCI
  unless methods.include? :devices
    def self.devices(node)
      case node['os']
      when 'windows'
        Windows.pci_devices
      when 'linux'
        Linux.pci_devices
      else
        ::Chef::Log.warn "[PCI] #{node['os']} is not a supported Operating System."
        ::Mash.new
      end
    end
  end

  # Retrieve a mapping between Windows PNPIDs & PCI slots
  unless methods.include? :pnp_mapping
    def self.pnp_mapping(node)
      raise '[PCI] pnp_mapping only available on Windows.' if node['os'] != 'windows'

      pci_devices = node['pci']['devices'] if node['pci']&.key?('devices')
      pci_devices = devices(node) if pci_devices.nil? || pci_devices.empty?

      pci_devices.map { |slot, device| [device['pnp_id'], slot] }.to_h
    end
  end
end
