#
# Cookbook Name:: resolvconf
# Test:: default
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
  include Helpers::Resolvconf

  it 'installs resolvconf package' do
    package('resolvconf').must_be_installed
  end

  it 'must set dns nameservers correctly' do
    file('/etc/resolv.conf').must_include('nameserver 8.8.8.8')
    file('/etc/resolv.conf').must_include('nameserver 8.8.4.4')
  end

  it 'must set dns search correctly' do
    # file('/etc/resolv.conf').must_include('search test.com example.com')
    file('/etc/resolv.conf').must_match(/^search .*test.com/)
    file('/etc/resolv.conf').must_match(/^search .*example.com/)
  end

  it 'must set dns options correctly' do
    file('/etc/resolv.conf').must_include('options rotate')
  end

  it 'makes sure all dns-* entries are removed from /etc/network/interfaces' do
    file('/etc/network/interfaces').wont_match(/'^\s*dns-'/)
  end
end
