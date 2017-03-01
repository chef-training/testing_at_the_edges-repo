#
# Cookbook Name:: aar
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aar::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '6.7')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs the application' do
      # allow(File).to receive(:exist?).with('/site/aar/install_complete_marker_file').and_return(false)
      # allow(File).to receive(:exist?).and_return(false)
      allow_any_instance_of(Chef::Resource::Execute).to receive(:install_complete_marker_file_present?).and_return(true)
      expect(chef_run).to run_execute('Install AAR Application')
    end
  end
end
