#
# Cookbook Name:: resolvconf
# Recipe:: default
#
# Copyright 2013, Chris Aumann
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

include_recipe 'resolvconf::install'

if value_for_platform({"ubuntu" => {"10.04" => true}, "default" => false})
  # fix buggy behaviour of resolvconf in ubuntu 10.04 (debian bug #642222)
  line = %q(\[ -f "$BASEFILE" \] \&\& RSLVCNFFILES="$BASEFILE)
  sfix = %q(\[ -f "$BASEFILE" \] \&\& RSLVCNFFILES="$RSLVCNFFILES\n$BASEFILE")
  unless %x(grep '#{line}' /etc/resolvconf/update.d/libc).empty?
    %x(cat /etc/resolvconf/update.d/libc | sed '/#{line}/{N;s/.*/#{sfix}/}' > /tmp/resolvconf_libc_642222.fix;
        cat /tmp/resolvconf_libc_642222.fix > /etc/resolvconf/update.d/libc;
        rm /tmp/resolvconf_libc_642222.fix
      )
  end
end

resolvconf 'default'
