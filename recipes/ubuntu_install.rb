#
# Cookbook Name:: collectd_install_configure
# Recipe:: ubuntu_install
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package "software-properties-common"
package "python-software-properties"

apt_repository "signalfx-collectd" do
  uri          "ppa:signalfx/collectd-release"
  distribution node["lsb"]["codename"]
  keyserver    "keyserver.ubuntu.com"
  key          "FE128AB0"
end

package "collectd"

