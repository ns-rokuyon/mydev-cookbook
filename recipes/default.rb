#
# Cookbook Name:: mydev
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group "wheel" do
    gid 10
    action :create
end

data_bag('users').each do |id|
    user = data_bag_item('users', id)

    user user['name'] do
        supports :manage_home => true
        home user['home']
        shell user['shell']
        password user['password']
        group user['group'] if user['group']
        action :create
    end
end

node["mydev"]["packages"].each do |pkg|
    package pkg do
        action :install
    end
end

directory "/home/ns64/git_repos" do
    action :create
end

git "/home/ns64/git_repos/dotfiles" do
    repository node["mydev"]["dotfiles_repos"]
    action :sync
end

template "/etc/sudoers.d/#{node["mydev"]["username"]}" do
    source "addusers.erb"
    owner "root"
    group "root"
    mode 400
end

