#
# Cookbook Name:: resolvconf
# Resource:: default
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

actions        :create
default_action :create

# DNS options (default to OpenDNS nameservers)
attribute :nameserver, kind_of: [Array, String], default: node['resolvconf']['nameserver']
attribute :search,     kind_of: [Array, String], default: node['resolvconf']['search']
attribute :options,    kind_of: [Array, String], default: node['resolvconf']['options']
attribute :sortlist,   kind_of: [Array, String], default: node['resolvconf']['sortlist']

# Remove all dns-* entries from /etc/network/interfaces
attribute :clear_dns_from_interfaces,
          kind_of: [TrueClass, FalseClass],
          default: node['resolvconf']['clear-dns-from-interfaces']

# set interface order file in /etc/resolvconf/interface-order
attribute :interface_order, 
          kind_of: [Array], 
          default: node['resolvconf']['interface-order']

# These elements will be placed in the corresponding file in /etc/resolvconf/resolv.conf.d/
attribute :head, kind_of: [Array, String], default: node['resolvconf']['head']
attribute :base, kind_of: [Array, String], default: node['resolvconf']['base']
attribute :tail, kind_of: [Array, String], default: node['resolvconf']['tail']
