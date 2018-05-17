require 'chefspec'
require 'spec_helper'

describe 'wkhtmltopdf-update::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['wkhtmltopdf-update']['version'] = '1.2.3'
    end.converge(described_recipe)
  end

  it 'includes the wkhtmltopdf-update::binary' do
    stub_command('/usr/local/bin/wkhtmltopdf --version | grep 1.2.3').and_return(false)
    expect(chef_run).to include_recipe('wkhtmltopdf-update::binary')
  end
end
