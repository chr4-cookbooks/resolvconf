# CHANGELOG for resolvconf

This file is used to list changes made in each version of resolvconf.

## 0.2.0:

* Remove potential symlinks before deploying new configuration

## 0.1.1:

* Add tests (using kitchen, see TESTING.md)
* Run resolvconf --enable-updates before resolvconf -u (when supported)
* Use Chef::Util::FileEdit instead of execute() and sed

## 0.1.0:

* Initial release of resolvconf
