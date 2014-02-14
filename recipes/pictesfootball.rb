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

include_recipe 'git'

user 'deploy'

directory '/var/www/pictesfootball.com' do
  owner 'deploy'
  group 'www-data'
  mode  '770'
end

package 'php5-fpm'

service 'php5-fpm' do
  action [:enable, :start]
end

cookbook_file '/etc/php5/fpm/pool.d/pictesfootball.com.conf' do
  source 'php-fpm.conf'
  notifies :restart, 'service[php5-fpm]'
end
