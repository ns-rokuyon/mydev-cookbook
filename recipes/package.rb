#
# Cookbook Name:: mydev
# Recipe:: package

node["mydev"]["package"]["list"].each do |pkg|
    package pkg do
        action :install
    end
end

