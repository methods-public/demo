# Load apps via attributes

node[:jackal][:apps].each do |name, definition|
  jackal name do
    definition.each do |key, value|
      self.send(key, value)
    end
  end
end
