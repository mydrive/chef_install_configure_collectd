#!/usr/bin/env ruby
#This recipe is for installing the collectd mongodb plugin.
include_recipe 'python'
include_recipe "python::pip"

case node[:platform]
    when "centos", "amazon"
    package [
        "collectd-python"
    ]
end

git "/tmp/collectd-mongodb" do
   repository 'git://github.com/signalfx/collectd-mongodb.git'
   reference 'master'
   action :sync
end
python_pip "virtualenv" do
  action :install
end

%w[ /etc/collectd.d /etc/collectd.d/managed_config ].each do |path|
  directory path do
    mode '0700'
    action :create
  end
end

#template "/etc/collectd.d/managed_config/10-mysql.conf" do
#  source "10-mysql-plugin.conf.erb"
#  variables({
#    :all_database => node[:mysql]
#  })
#end

service 'collectd' do
  action [:enable, :stop, :start]
end
