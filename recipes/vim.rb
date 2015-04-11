#
# Cookbook Name:: mydev
# Recipe:: vim

if platform? "redhat"
    link "/usr/share/perl5/ExtUtils/xsubpp" do
        to "/usr/bin/xsubpp"
    end
end

include_recipe "vim::source"
