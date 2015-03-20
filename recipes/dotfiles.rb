#
# Cookbook Name:: mydev
# Recipe:: dotfiles

username = node["mydev"]["username"]
dotfiles_dir = "/home/#{username}/git_repos/dotfiles"

directory "/home/#{username}/git_repos" do
    user username
    group username
    mode 0755
    action :create
end

git dotfiles_dir do
    repository node["mydev"]["dotfiles"]["git"]
    user username
    group username
    action :sync
end

node["mydev"]["dotfiles"]["files"].each do |file|
    file "/home/#{username}/#{file}" do
        content IO.read("#{dotfiles_dir}/#{file}")
    end
end

node["mydev"]["dotfiles"]["dirs"].each do |dir|
    bash "mv dirs: #{dir}" do
        cwd "/home/#{username}"
        code <<-EOC
           cp -r #{dotfiles_dir}/#{dir} ./
        EOC
    end
end

git "/home/#{username}/.oh-my-zsh" do
    repository "https://github.com/robbyrussell/oh-my-zsh.git"
    reference "master"
    action :checkout
    user username
    group username
end
