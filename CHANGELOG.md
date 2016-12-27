# CHANGELOG for resolvconf

This file is used to list changes made in each version of resolvconf.

## 0.4.0:

- Remove support for Ubuntu 10.04 (Official support ended Q1 2015)

## 0.3.0:

- Add default interface names for Ubuntu Xenial 16.04

## 0.2.10:

- Add custom matcher for ChefSpec

## 0.2.9:

- Use `use_inline_resources` to fix a bug with `resolvconf -u` not being immediately called.

## 0.2.8:

- Allow `wipe_runtime_directory` to be specified as resource attribute. Defaults to node attribute.

## 0.2.7:

- Add support for interface-order
- Make sure `/etc/resolv.conf` is a symlink to `/run/resolvconf/resolv.conf`

## 0.2.6:

- `/run/resolvconf/interface/` is wiped only when `node['resolvconf']['wipe-runtime-directory']` is
  set to `true`. Defaults to false. This resolves issues with applications using the dynamic
  nameserver configuration capabilities of resolvconf.

## 0.2.5:

- Include a workaround for Ubuntu-10.04 (Debian bug #642222)

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
