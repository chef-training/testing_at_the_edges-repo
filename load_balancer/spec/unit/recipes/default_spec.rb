#
# Cookbook Name:: load_balancer
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'load_balancer::default' do
  context 'With a SoloRunner' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'centos', version: '6.7')
      runner.converge(described_recipe)
    end

    before do
      stub_search('node','role:web').and_return([ { 'cloud' => { 'public_ipv4' => '192.168.0.1' } }])
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'writes the correct template' do
      expect(chef_run).to render_file('/etc/haproxy/haproxy.cfg').with_content('server app0 192.168.0.1:80')
    end
  end

  # I could not get the ServerRunner to correctly allow me to create a role,
  # assign that role to the node, and then have that node come back from search.
  #
  # I will explore this further but stick with the SoloRunner.
  #

  # context 'With a ServerRunner' do
  #   let(:chef_run) do
  #     runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '6.7') do |node,server|
  #       server.create_role('web', { default_attributes: {} })
  #       server.create_node('node1', { :run_list => ['role:web'], 'roles' => 'web', 'cloud' => { 'public_ipv4' => '192.168.0.1' }  })
  #       server.create_node(node1)
  #     end
  #     runner.converge(described_recipe)
  #   end
  #
  #   it 'converges successfully' do
  #     expect { chef_run }.to_not raise_error
  #   end
  #
  #   it 'writes the correct template' do
  #     expect(chef_run).to render_file('/etc/haproxy/haproxy.cfg').with_content('server app0 192.168.0.1:80')
  #   end
  # end
end
