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
