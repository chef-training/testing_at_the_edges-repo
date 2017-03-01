#
# Cookbook Name:: ssh
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'ssh::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'mac_os_x', version: '10.12')
      runner.converge(described_recipe)
    end

    before do
      stub_command('/usr/sbin/systemsetup -getremotelogin | /usr/bin/grep On').and_return(false)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'enables ssh' do
      expect(chef_run).to run_execute('enable SSH')
    end
  end
end
