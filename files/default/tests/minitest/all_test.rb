#
# Cookbook Name:: resolvconf
# Test:: all
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

require File.expand_path('../support/helpers', __FILE__)

describe 'resolvconf::default' do
  include Helpers::TestHelper

  it 'installs resolvconf package' do
    package('resolvconf').must_be_installed
  end

  it 'sets dns nameservers correctly' do
    file('/etc/resolv.conf').must_match(/^nameserver\s+8\.8\.8\.8$/)
    file('/etc/resolv.conf').must_match(/^nameserver\s+8\.8\.4\.4$/)
  end

  it 'sets dns search correctly' do
    # Check whether both domains exist in search list, and whether they are in the same line
    file('/etc/resolv.conf').must_match(/^search\s+.*example.com/)
    file('/etc/resolv.conf').must_match(/^search\s+.*test.com/)
    file('/etc/resolv.conf').must_match(/^search\s+(test.com|example.com)\s+(test.com|example.com)$/)
  end

  it 'sets dns options correctly' do
    file('/etc/resolv.conf').must_match(/^options\s+rotate$/)
  end

  it 'sets dns sortlist correctly' do
    file('/etc/resolv.conf').must_match(/^sortlist\s+130\.155\.160\.0\/255\.255\.240\.0\s+130\.155\.0\.0$/)
  end

  it 'makes sure all dns-* entries are removed from /etc/network/interfaces' do
    file('/etc/network/interfaces').wont_match(/'^\s*dns-'/)
  end
end
