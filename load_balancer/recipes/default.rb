#
# Cookbook Name:: load_balancer
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

package 'haproxy'

allwebservers = search('node','role:web')
ip_addresses = allwebservers.map { |node| node['cloud']['public_ipv4'] }

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  variables(
    :webservers => ip_addresses
  )
 notifies :restart, 'service[haproxy]'
end

service 'haproxy' do
  action [:start, :enable]
end
