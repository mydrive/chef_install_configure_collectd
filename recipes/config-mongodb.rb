case node[:platform]
  when "centos", "amazon"
    package [ 
          "collectd-python"
        ]
end

%w[ /etc/collectd.d /etc/collectd.d/managed_config ].each do |path|
  directory path do
    mode '0700'
    action :create
  end
end

template "/etc/collectd.d/managed_config/10-mongodb.conf" do
  source "10-mongodb-plugin.conf.erb"
  variables({
    :all_database => node[:mysql]
  })
end

service 'collectd' do
  action [:enable, :stop, :start]
end
/opt/signalfx-collectd-plugin/
