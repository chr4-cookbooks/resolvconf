# resolvconf Cookbook

This cookbook maintains /etc/resolv.conf using the resolvconf package, which is installed by default on Debian/Ubuntu.

## Requirements

A system that supports resolvconf.

- Ubuntu >= 10.04
- Debian >= 6.0

Furthermore you need to add the following line to your metadata.rb

    depends 'resolvconf'


## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['resolvconf']['nameserver']</tt></td>
    <td>String, Array</td>
    <td>Nameserver(s) to use</td>
    <td>OpenDNS Nameservers: <tt>[ '208.67.222.222', '208.67.220.220' ]</tt></td>
  </tr>
  <tr>
    <td><tt>['resolvconf']['search']</tt></td>
    <td>String, Array</td>
    <td>Domain(s) to add to search</td>
    <td><tt>node['domain']</tt></td>
  </tr>
  <tr>
    <td><tt>['resolvconf']['options']</tt></td>
    <td>String, Array</td>
    <td>Other options, e.g. 'rotate'</td>
    <td><tt>[]</tt></td>
  </tr>

  <tr>
    <td><tt>['resolvconf']['head']</tt></td>
    <td>String, Array</td>
    <td>String(s) to be placed at the top of /etc/resolv.conf, typically a warning</td>
    <td><tt>[ '# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)',
              '#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN' ]</tt></td>
  </tr>
  <tr>
    <td><tt>['resolvconf']['base']</tt></td>
    <td>String, Array</td>
    <td>String(s) to be placed in the of /etc/resolv.conf, typically configuration like nameserver, search, options</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['resolvconf']['tail']</tt></td>
    <td>String, Array</td>
    <td>String(s) to be placed at the bottom of /etc/resolv.conf</td>
    <td><tt>[]</tt></td>
  </tr>

  <tr>
    <td><tt>['resolvconf']['clear-dns-from-interfaces']</tt></td>
    <td>Boolean</td>
    <td>Remove dns-* settings from /etc/network/interfaces, as they might interferre with the configured settings</td>
    <td><tt>true</tt></td>
  </tr>
</table>


## Provider

### resolvconf

The LWRP basically supports all options that can be set via attributes, and uses the same defaults.
It will do the following

- It will create the necessary files in /etc/resolvconf/resolv.conf.d/
- Remove dns-* lines from /etc/network/interfaces (unless clear_dns_form_interfaces is specified)
- Run 'resolvconf -u'


Example:

```ruby
resolvconf 'default'
```

```ruby
resolvconf 'custom' do
  nameserver '8.8.8.8'
  search     'mydomain.com'
  options    'rotate'

  head       "# Don't touch this configuration file!"
  base       "# Will be added after nameserver, search, options config items"
  tail       "# This goes to the end of the file."

  # do not touch my interface configuration plz!
  clear_dns_from_interfaces false
end
```


## Recipes

### resolvconf:install

Installs the resolvconf package.


### resolvconf::default

Includes resolvconf::install, then configures the node using the specified attributes / defaults.



# Contributing

Contributions are very welcome!

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github


# License and Authors

Authors: Chris Aumann <me@chr4.org>

License: GPLv3
