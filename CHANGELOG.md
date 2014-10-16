# CHANGELOG for resolvconf

This file is used to list changes made in each version of resolvconf.

## 0.2.4:

- Remove support for the domain attribute, as resolvconf ignores it. Use search attribute instead.

## 0.2.3:

- Add support for sortlist and domain settings

## 0.2.2:

- Remove a workaround for `force_unlink`, fix was merged in Chef 11.12.0
- Clear `/run/resolvconf/interface/` directory before updating `/etc/resolv.conf`, to prevent
  deprecated entries from ending up in the file

## 0.2.1:

* Add small workaround for `force_unlink` bug in Chef, fixed (but not released) in
  https://github.com/opscode/chef/pull/1383

## 0.2.0:

* Remove potential symlinks before deploying new configuration

## 0.1.1:

* Add tests (using kitchen, see TESTING.md)
* Run resolvconf --enable-updates before resolvconf -u (when supported)
* Use Chef::Util::FileEdit instead of execute() and sed

## 0.1.0:

* Initial release of resolvconf
