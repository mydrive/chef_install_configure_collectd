# Recipe:: config-collectd
#
# Function:
# This recipe can configure the write_http plugin to send metrics to signalfx
#
# Copyright (c) 2015 SignalFx, Inc, All Rights Reserved.

#
# This fucntion is to get collectd configure file path. For centos and amazon,
# the path is on /etc/collectd.conf. For ubuntu, the path is on /etc/collectd/collectd.conf.
#
require_relative './helper.rb'

if node['platform'] == 'centos' or node['platform'] == 'amazon'
  package 'collect-write_http'
end

ingesturl = getHttpUri

template "#{node['collectd_conf_folder']}/10-write_http-plugin.conf" do
  source '10-write_http-plugin.conf.erb'
  variables({
    :INGEST_HOST => ingesturl, 
    :API_TOKEN => node['write_http']['API_TOKEN']
  })
end

service 'collectd' do
  action [:enable, :stop, :start]
end
