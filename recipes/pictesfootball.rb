#
# Cookbook Name:: apps
# Recipe:: pictesfootball
#
# Copyright (C) 2014 Renaud Martinet
# 
# All rights reserved - Do Not Redistribute
#

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
  group 'www-data'
end

directory "/var/www/#{node['pictesfootball']['domain']}" do
  owner node['pictesfootball']['deploy']['user']
  group 'www-data'
  mode  '770'
end

directory "/var/log/#{node['pictesfootball']['domain']}" do
  owner node['pictesfootball']['deploy']['user']
  group 'www-data'
  mode  '775'
end

directory "/var/cache/#{node['pictesfootball']['domain']}" do
  owner node['pictesfootball']['deploy']['user']
  group 'www-data'
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

template "/etc/nginx/sites-available/#{node['pictesfootball']['domain']}" do
  source 'nginx-vhost.conf'
end

link "/etc/nginx/sites-enabled/#{node['pictesfootball']['domain']}" do
  to "/etc/nginx/sites-available/#{node['pictesfootball']['domain']}"
  notifies :restart, 'service[nginx]'
end
