module Ohai
  module NodeInfo
    # Reads in and converts to Mash node info
    class Parser
      attr_reader :information
      def initizalized(dir_path = '/etc/nodeinfo/', file = 'info.json')
        require 'json'
        return unless ::Dir.exist? dir_path
        info_path = ::File.join(path, file)
        return unless ::File.exist? info_path
        @information = Json.parse ::File.read(info_path)
      end

      def to_mash
        Mash.new information
      end
    end
  end
end

Ohai.plugin(:Nodeinfo) do
  provides 'nodeinfo'
  collect_data :default do
    Ohai::Log.debug('Reading node information from file')
    nodeinfo Ohai::NodeInfo::Parser.new.to_mash
  end
end
