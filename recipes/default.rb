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

template "/etc/sudoers.d/#{node["mydev"]["username"]}" do
    source "addusers.erb"
    owner "root"
    group "root"
    mode 400
end

node["mydev"]["packages"].each do |pkg|
    package pkg do
        action :install
    end
end

directory "/home/#{node["mydev"]["username"]}/git_repos" do
    user node["mydev"]["username"]
    group "users"
    mode 0755
    action :create
end

dotfiles_dir = "/home/#{node["mydev"]["username"]}/git_repos/dotfiles"
git dotfiles_dir do
    repository node["mydev"]["dotfiles_repos"]
    user node["mydev"]["username"]
    group "users"
    action :sync
end

node["mydev"]["setup_dotfiles"].each do |file|
    file "/home/#{node["mydev"]["username"]}/#{file}" do
        content IO.read("#{dotfiles_dir}/#{file}")
    end
end

bash "mv dirs" do
    cwd "/home/#{node["mydev"]["username"]}"
    code <<-EOC
       cp -r #{dotfiles_dir}/misc ./
       cp -r #{dotfiles_dir}/.vim ./
    EOC
end

git "/home/#{node["mydev"]["username"]}/.oh-my-zsh" do
    repository "https://github.com/robbyrussell/oh-my-zsh.git"
    reference "master"
    action :checkout
    user node["mydev"]["username"]
    group node["mydev"]["username"]
end
