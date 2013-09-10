#
# Cookbook Name:: resolvconf
# Provider:: fallback
#
# Copyright 2012, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Fallback to /etc/resolv.conf in case resolvconf package is not existent
# (e.g. on RHEL systems)
action :create do
  content = []
  content << Array(new_resource.head) unless Array(new_resource.head).empty?
  content << Array(new_resource.nameserver).map { |ns| "nameserver #{ns}"} unless Array(new_resource.nameserver).empty?
  content << Array("search #{Array(new_resource.search).join(' ')}") unless Array(new_resource.search).empty?
  content << Array(new_resource.options).map { |opt| "options #{opt}"} unless Array(new_resource.options).empty?
  content << Array(new_resource.base) unless Array(new_resource.base).empty?
  content << Array(new_resource.tail) unless Array(new_resource.tail).empty?

  r = file '/etc/resolv.conf' do
    mode    00644
    content "#{content.join("\n")}\n"
  end

  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end
