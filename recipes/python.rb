#
# Cookbook Name:: mydev
# Recipe:: python
#

cache_dir = Chef::Config["file_cache_path"]
version = node["mydev"]["python"]["version"]
prefix_path = node["mydev"]["python"]["prefix"]

remote_file "#{cache_dir}/Python-#{version}.tgz" do
    source "https://www.python.org/ftp/python/#{version}/Python-#{version}.tgz"
end

bash "install python" do
    cwd cache_dir
    code <<-EOC
        tar zxvf Python-#{version}.tgz
        cd Python-#{version}
        ./configure --prefix=#{prefix_path}
        make
        make install
    EOC
    not_if "ls #{prefix_path}/bin/python"
end

bash "install pip" do
    cwd cache_dir
    code <<-EOC
        wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
        python2.7 ez_setup.py
        easy_install-2.7 pip
    EOC
    not_if "ls #{prefix_path}/bin/pip"
end
