#
# Cookbook Name:: aar
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

execute 'Install AAR Application' do
  extend AARHelpers
  command 'python /app/AARinstall.py'
  not_if do
    # File.exist?('/site/aar/install_complete_marker_file')
    install_complete_marker_file_present?
  end
end
