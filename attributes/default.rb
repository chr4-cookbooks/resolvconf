#
# Cookbook Name:: resolvconf
# Attribute:: default
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

default['resolvconf']['head'] = [
  '# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)',
  '#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN'
]

default['resolvconf']['base'] = []
default['resolvconf']['tail'] = []

# Shortcuts for specify /etc/resolv.conf options (will be added to node['resolvconf']['base'])
default['resolvconf']['nameserver'] = []  # default empty else chef merges with any user provided ones
default['resolvconf']['search'] = node['domain']
default['resolvconf']['sortlist'] = []
default['resolvconf']['options'] = []

# Remove all dns-* entries from /etc/network/interfaces
default['resolvconf']['clear-dns-from-interfaces'] = true

# Wipe runtime directory to make sure old resolv.conf entries are properly removed.
# This is not enabled by default, as it breaks the dynamic capabilities for applications to change
# nameserver entries.
default['resolvconf']['wipe-runtime-directory'] = false

# These are the defaults, so lets place them here as to not disrupt the current state of things.
default['resolvconf']['interface-order'] =
  # Xenial updated the defaults
  if node['platform_version'].to_f >= 16.04
    [
      'lo.inet6',
      'lo.inet',
      'lo.@(dnsmasq|pdnsd)',
      'lo.!(pdns|pdns-recursor)',
      'lo',
      'tun*',
      'tap*',
      'hso*',
      'em+([0-9])?(_+([0-9]))*',
      'p+([0-9])p+([0-9])?(_+([0-9]))*',
      '@(br|eth)*([^.]).inet6',
      '@(br|eth)*([^.]).ip6.@(dhclient|dhcpcd|pump|udhcpc)',
      '@(br|eth)*([^.]).inet',
      '@(br|eth)*([^.]).@(dhclient|dhcpcd|pump|udhcpc)',
      '@(br|eth)*',
      '@(ath|wifi|wlan)*([^.]).inet6',
      '@(ath|wifi|wlan)*([^.]).ip6.@(dhclient|dhcpcd|pump|udhcpc)',
      '@(ath|wifi|wlan)*([^.]).inet',
      '@(ath|wifi|wlan)*([^.]).@(dhclient|dhcpcd|pump|udhcpc)',
      '@(ath|wifi|wlan)*',
      'ppp*',
      '*',
    ]
  else
    [
      'lo.dnsmasq',
      'lo.pdnsd',
      'lo.!(pdns|pdns-recursor)',
      'lo',
      'tun*',
      'tap*',
      'hso*',
      'em+([0-9])?(_+([0-9]))*',
      'p+([0-9])p+([0-9])?(_+([0-9]))*',
      'eth*',
      'ath*',
      'wlan*',
      'ppp*',
      '*'
    ]
  end
