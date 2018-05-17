guard :rspec, cmd: 'rspec', :all_on_start => true do  
  watch(%r{^spec/(.+)_spec\.rb$})
  watch(%r{^(recipes)/(.+)\.rb$})   { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')      { 'spec' }
end
