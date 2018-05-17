property :destination, String, name_property: true
property :repository, String
property :config, kind_of: Hash, default: {}

default_action :checkout

action :checkout do
  daun = ::Daun::RuggedDaun.new(destination)
  unless ::File.foreach("#{destination}/.git/config").any? { |l| l[repository] }
    converge_by("Initialize daun repository at #{destination}") do
      daun.init repository
    end
  end

  config.each do |key, value|
    next if daun.config[key] == value.to_s
    converge_by("Update daun repository config '#{key}' to '#{value}'") do
      daun.config[key] = value
    end
  end

  converge_by("Checkout daun repository at #{destination}") do
    puts
    daun.checkout
  end
end
