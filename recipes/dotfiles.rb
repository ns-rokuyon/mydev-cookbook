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
    action :sync
end

node["mydev"]["dotfiles"]["files"].each do |file|
    bash "dotfiles: #{file}" do
        cwd "/home/#{username}"
        code <<-EOC
            cp #{dotfiles_dir}/#{file} ./
        EOC
    end
end

node["mydev"]["dotfiles"]["dirs"].each do |dir|
    bash "mv dirs: #{dir}" do
        cwd "/home/#{username}"
        code <<-EOC
           cp -r #{dotfiles_dir}/#{dir} ./
           chown -R #{username}:wheel #{dir}
        EOC
    end
end

git "/home/#{username}/.oh-my-zsh" do
    repository "https://github.com/robbyrussell/oh-my-zsh.git"
    reference "master"
    action :checkout
    user username
end

directory "/home/#{username}/.vim/bundle" do
    user username
    action :create
end

git "/home/#{username}/.vim/neobundle.vim.git" do
    repository "https://github.com/Shougo/neobundle.vim"
    reference "master"
    action :checkout
    user username
end
