#
# Cookbook Name:: mydev
# Recipe:: ruby

username = node["mydev"]["username"]
rbenv_dir = node["mydev"]["ruby"]["rbenv_dir"]
rbenv_plugin_dir = "#{rbenv_dir}/plugins"
ruby_global_version = node["mydev"]["ruby"]["global"]

git "/home/#{username}/#{rbenv_dir}" do
    repository "https://github.com/sstephenson/rbenv.git"
    revision "master"
    user username
    group username
    action :checkout
end

directory "/home/#{username}/#{rbenv_plugin_dir}" do
    user username
    group username
    action :create
end

git "/home/#{username}/#{rbenv_plugin_dir}/ruby-build" do
    repository "https://github.com/sstephenson/ruby-build.git"
    revision "master"
    user username
    group username
    action :checkout
end

node["mydev"]["ruby"]["versions"].each do |version|
    execute "rbenv install #{version}" do
        command "su #{username} -l -c 'rbenv versions | grep #{version} > /dev/null; if [ $? -ne 0 ]; then rbenv install #{version}; fi'"
    end
end

execute "rbenv rehash" do
    command "su #{username} -l -c 'rbenv rehash'"
end

execute "rbenv global #{ruby_global_version}" do
    command "su #{username} -l -c 'rbenv global #{ruby_global_version}'"
end
