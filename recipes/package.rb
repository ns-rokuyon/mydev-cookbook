#
# Cookbook Name:: mydev
# Recipe:: package

if platform? "redhat"
    bash "redhat repo" do
        code <<-EOC
            yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
        EOC
    end
end

node["mydev"]["package"]["list"].each do |pkg|
    package pkg do
        action :install
    end
end

