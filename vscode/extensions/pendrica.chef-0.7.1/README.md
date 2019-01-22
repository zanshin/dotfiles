# Chef Extension for Visual Studio Code

The Chef Extension for Visual Studio Code offers rich language support for Chef DSL and snippets when using [Visual Studio Code](http://code.visualstudio.com).

![install and demo](https://github.com/pendrica/vscode-chef/raw/master/images/vscode-chef-install.gif)

## Features
#### Syntax/keyword highlighting:
 * Chef Recipe DSL
 * Chef Provisioning DSL
 * Chef built-in Resources
 * Chef Custom Resources

#### Rubocop linting:
 * Enabled by default (disable by adding ```{ "rubocop.enable": false }``` in user/workspace settings)
 * Entire repo will be linted when files are saved.
 * If you have the [ChefDK](http://downloads.chef.io/chef-dk) installed, linting should "just work" on Windows, Mac OS X and Linux (Ubuntu.) [Cookstyle](https://github.com/chef/cookstyle) will be used by default.
 * If you do not have the ChefDK but do have Rubocop installed, you can set the executable path by setting ```{ "rubocop.path": "c:\\path\\to\\rubocop.bat"}``` in user/workspace settings).
 * To override the config file used by Rubocop/Cookstyle, use the ```{ "rubocop.configFile": "path/to/config.yml" }``` in user/workspace settings.

#### Foodcritic analysis (experimental):
 * Disabled by default (enable by adding ```{ "foodcritic.enable": true }``` in user/workspace settings)
 * When Ruby files are saved, the entire repo will be enumerated for cookbooks and Foodcritic run against each one.
 * If you have the [ChefDK](http://downloads.chef.io/chef-dk) installed, Foodcritic should "just work" on Windows, Mac OS X and Linux (Ubuntu)
 * If you do not have the ChefDK but do have Foodcritic installed, you can set the executable path by setting ```{ "foodcritic.path": "c:\\path\\to\\foodcritic.bat"}``` in user/workspace settings).

#### Snippet support (with tabbing) for all Chef built-in Resources:
 * apt_package
 * apt_preference
 * apt_repository
 * apt_update
 * bash
 * batch
 * bff_package
 * breakpoint
 * cab_package
 * chef_gem
 * chef_handler
 * chocolatey_package
 * cookbook_file
 * cron
 * csh
 * describe
 * directory
 * dmg_package
 * dnf_package
 * dpkg_package
 * dsc_resource
 * dsc_script
 * execute
 * expect
 * file
 * freebsd_package
 * gem_package
 * git
 * group
 * homebrew_cask
 * homebrew_package
 * homebrew_tap
 * hostname
 * http_request
 * ifconfig
 * ips_package
 * it
 * ksh
 * launchd
 * let
 * link
 * log
 * macos_userdefaults
 * macports_package
 * mdadm
 * mount
 * msu_package
 * ohai_hint
 * ohai
 * openbsd_package
 * openssl_dhparam
 * openssl_rsa_private_key
 * openssl_rsa_public_key
 * osx_profile
 * package
 * pacman_package
 * paludis_package
 * perl
 * portage_package
 * powershell_package
 * powershell_script
 * python
 * reboot
 * registry_key
 * remote_directory
 * remote_file
 * rhsm_errata_level
 * rhsm_errata
 * rhsm_register
 * rhsm_repo
 * rhsm_subscription
 * route
 * rpm_package
 * ruby
 * ruby_block
 * script
 * service
 * smartos_package
 * solaris_package
 * subversion
 * sudo
 * swap_file
 * sysctl
 * systemd_unit
 * template
 * user
 * windows_ad_join
 * windows_auto_run
 * windows_env
 * windows_feature
 * windows_feature_dism
 * windows_feature_powershell
 * windows_font
 * windows_package
 * windows_path
 * windows_printer
 * windows_printer_port
 * windows_service
 * windows_shortcut
 * windows_task
 * yum_package
 * yum_repository
 * zypper_package
 * zypper_repository

 Press ```Ctrl+Space``` (Windows, Linux) or ```Control+Space``` (OSX) to activate snippets from within the editor.

 With more features yet to come, stay tuned.

## Installation

 * You will need to install Visual Studio Code `1.0` or higher.
 * From the command palette ```Ctrl-Shift-P``` (Windows, Linux) or ```Cmd-Shift-P``` (OSX) select `Install Extension`, choose `Chef` and reload Visual Studio Code.  

## Backlog

 * Investigate auto-suggestions and extend syntax highlighting/colouring.
 * Investigate auto-correct options on Rubocop findings.
 * Investigate integration with ChefSpec.

## Contributions

Contributions are welcomed, please file issues and pull requests via the [project homepage](https://github.com/pendrica/vscode-chef).

## Author

This extension was written by Stuart Preston [stuart@chef.io](https://github.com/pendrica/vscode-chef/blob/master/stuart@chef.io)

## License
This extension is licensed under an [Apache 2](https://github.com/pendrica/vscode-chef/blob/master/LICENSE.md) license.

(c) 2015-2017 Pendrica
