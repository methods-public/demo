require File.expand_path('../support/helpers', __FILE__)

describe_recipe "lastrun_handler::default" do
  include Helpers::LastRunHandler

  it "creates lastrun handler" do
    file("#{node['chef_handler']['handler_path']}/lastrun_update.rb").must_exist
  end
end
