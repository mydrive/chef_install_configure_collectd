case node[:platform]
  when "centos", "amazon"
    package [ 
          "collectd-mysql"
        ]
end

%w[ /etc/collectd.d /etc/collectd.d/managed_config ].each do |path|
  directory path do
    mode '0700'
    action :create
  end
end

template "/etc/collectd.d/managed_config/10-mysql.conf" do
  source "10-mysql-plugin.conf.erb"
  variables({
    :all_database => node[:mysql]
  })
end

service 'collectd' do
  action [:enable, :stop, :start]
end
