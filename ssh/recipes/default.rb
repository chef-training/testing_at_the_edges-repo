#
# Cookbook Name:: ssh
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

execute 'enable SSH' do
  command '/usr/sbin/systemsetup -setremotelogin on'
  not_if '/usr/sbin/systemsetup -getremotelogin | /usr/bin/grep On'
  action :run
end
