#
# Cookbook Name:: apps
# Recipe:: pictesfootball
#
# Copyright (C) 2014 Renaud Martinet
# 
# All rights reserved - Do Not Redistribute
#

node.set['pictesfootball']['deploy']['group'] = node['pictesfootball']['web']['group']
node.set['nginx']['user'] = node['pictesfootball']['web']['user']
node.set['nginx']['group'] = node['pictesfootball']['web']['group']

include_recipe 'apt'

package 'nginx'

service 'nginx' do
  action [:enable, :start]
end

package 'php5'

package 'php5-curl' do
  notifies :restart, 'service[php5-fpm]'
end

include_recipe 'git'

user node['pictesfootball']['deploy']['user'] do
  group node['pictesfootball']['deploy']['group']
end

directory "/var/www/#{node['pictesfootball']['domain']}" do
  owner node['pictesfootball']['deploy']['user']
  group node['pictesfootball']['deploy']['group']
  mode  '770'
end

directory "/var/log/#{node['pictesfootball']['domain']}" do
  owner node['pictesfootball']['deploy']['user']
  group node['pictesfootball']['deploy']['group']
  mode  '775'
end

directory "/var/cache/#{node['pictesfootball']['domain']}" do
  owner node['pictesfootball']['deploy']['user']
  group node['pictesfootball']['deploy']['group']
  mode  '775'
end

package 'php5-fpm'

service 'php5-fpm' do
  action [:enable, :start]
end

template "/etc/php5/fpm/pool.d/#{node['pictesfootball']['domain']}.conf" do
  source 'php-fpm.conf'
  notifies :restart, 'service[php5-fpm]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end

template "/etc/nginx/sites-available/#{node['pictesfootball']['domain']}" do
  source 'nginx-vhost.conf'
end

link "/etc/nginx/sites-enabled/#{node['pictesfootball']['domain']}" do
  to "/etc/nginx/sites-available/#{node['pictesfootball']['domain']}"
  notifies :restart, 'service[nginx]'
end
