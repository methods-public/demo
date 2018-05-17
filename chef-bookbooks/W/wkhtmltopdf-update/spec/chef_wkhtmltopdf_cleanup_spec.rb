require 'chefspec'
require 'spec_helper'

describe 'wkhtmltopdf-update::chef_wkhtmltopdf_cleanup' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'removes the old wkhtmltopdf file' do
    expect(chef_run).to delete_file('/usr/local/bin/wkhtmltopdf')
  end

  it 'removes the old wkhtmltoimage file' do
    expect(chef_run).to delete_file('/usr/local/bin/wkhtmltoimage')
  end
end
