#
# Cookbook Name:: mydev
# Recipe:: default

include_recipe "mydev::user"
include_recipe "mydev::package"
include_recipe "mydev::dotfiles"
