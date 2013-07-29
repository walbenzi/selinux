#
# Author:: Sean OMeara (<someara@opscode.com>)
# Cookbook Name:: selinux
# Recipe:: enforcing
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

template "/etc/selinux/config" do
  source "sysconfig/selinux.erb"
  action :create
end

#Note that a Disabled, non-forced node will continue to operate incorrectly
if node['force_reboot_if_needed'] == "true"
  execute "reboot to reload the a SELinux enabled kernel" do
    only_if "getenforce | grep Disabled"
    command "reboot"
    action :run
  end
end

execute "disable selinux enforcement" do
  only_if "getenforce | grep Permissive"
  command "setenforce 1" #Permissive is the best we can do without a reboot
  action :run
end
