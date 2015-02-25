#
# Cookbook Name:: resolvconf
# Provider:: default
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

action :create do
  options = {}
  options['head'] = Array(new_resource.head)
  options['base'] = Array(new_resource.nameserver).map { |ns| "nameserver #{ns}" }
  options['base'] += Array("search #{Array(new_resource.search).join(' ')}") unless Array(new_resource.search).empty?
  options['base'] += Array(new_resource.sortlist).map { |sortlist| "sortlist #{sortlist}" }
  options['base'] += Array(new_resource.options).map { |opt| "options #{opt}" }
  options['base'] += Array(new_resource.base)
  options['tail'] = Array(new_resource.tail)

  options.each do |name, _|
    file "/etc/resolvconf/resolv.conf.d/#{name}" do
      mode    00644
      content "#{options[name].join("\n")}\n"

      # Remove file if it is not a regular file (e.g. a symlink)
      # This is useful, as sometimes the backup stored in the file "original"
      # is symlinked to "tail"
      #
      # Due to a bug in chef (fixed with https://github.com/opscode/chef/pull/1383, but not released yet),
      # we need to check whether the file actually exists before setting force_unlink
      force_unlink true if ::File.exist?("/etc/resolvconf/resolv.conf.d/#{name}")
      notifies :run, "execute[resolvconf -u]"
    end
  end

  if new_resource.clear_dns_from_interfaces
    interfaces = Chef::Util::FileEdit.new('/etc/network/interfaces')
    interfaces.search_file_delete_line(/^\s*dns-/)
    interfaces.write_file
  end

  # Wipe old configuration settings from runtime directory, as they'd end up in /etc/resolv.conf
  # otherwise. Older systems do not support this, should fail silently though.
  execute 'rm -f /run/resolvconf/interface/*' if node['resolvconf']['wipe-runtime-directory']

  execute 'resolvconf --enable-updates' do
    # Older systems do not support --enable-updates, but should work nonetheless
    not_if "resolvconf --updates-are-enabled"
    ignore_failure true
  end
  
  template '/etc/resolvconf/interface-order' do
    source 'interface-order.erb'
    variables(
      :interfaces => new_resource.interface_order
      )
    notifies :run, "execute[resolvconf -u]"
  end

  execute 'resolvconf -u' do
    action :nothing
  end
end
