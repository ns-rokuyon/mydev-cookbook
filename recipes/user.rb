#
# Cookbook Name:: mydev
# Recipe:: user

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

