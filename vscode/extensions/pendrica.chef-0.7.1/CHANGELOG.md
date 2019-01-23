## 0.7.1 (2018-11-05)
 - Updated apt_upgrade snippet (@brooksa321, @rreilly-edr)

## 0.7.0 (2018-05-13)
 - Additional snippets from Chef 14 (@kitforbes, @tas50)
 - Set vscode NPM package to 1.1.14 (@SeanSith)
 - Fixes to Foodcritic output on save (@SeanSith)

## 0.6.4 (2017-12-04)
 - Additional snippets from Chef 13 (@tas50)
 - Fix to Foodcritic output formatting (@stuartpreston) [#16](https://github.com/pendrica/vscode-chef/issues/16)
 - Logo switched to png to comply with publishing rules (@stuartpreston)

## 0.6.3 (2017-06-06)
 - Allow `rubocop.configFile` workspace parameter (@stuartpreston)

## 0.6.2 (2016-11-04)
 - Use Cookstyle in place of Rubocop by default (@smith)

## 0.6.1 (2016-06-09)
 - Adding ChefSpec 'describe' snippet (@jerry-locke)

## 0.6.0 (2016-05-16)
 - Bug: Foodcritic was only displaying the first warning from each file inspected
 - Bug: Cookbook folders opened directly were not being detected as a cookbook (#7)
 - Bug: Cookbook folder detection occurred for Foodcritic on each document save even when foodcritic.enable was set to false
 - Improve end-to-end Foodcritic performance by only checking cookbooks with a metadata.rb
 - Change default location of Rubocop and Foodcritic to /opt/chefdk/embedded/bin (and respective location on Windows) for compatibility with ChefDK 0.13+ 
 - Foodcritic would not return the complete set of results across multiple cookbooks in a "mega-repo"

## 0.5.2 (2016-04-26)

Bugfixes:
 - Move cookbook folder selection inside feature flag for Foodcritic (@stuartpreston)

## 0.5.1 (2016-04-25)

Bugfixes:
 - Embed README.md in packaged .vsix file (@stuartpreston)

## 0.5.0 (2016-04-25)

Features: 
 - Experimental support for Foodcritic (enable by setting the ```foodcritic.enable``` to ```true``` in your settings.json) (@stuartpreston)
 - Rubocop messages that originated at Convention/Refactor level are now shown at at Informational level in VS Code (previously the default level was "warning") (@stuartpreston)

## 0.4.4 (2015-12-19)

Bugfixes:
 - Reduce download time by removing huge gif from package (@stuartpreston)

## 0.4.3 (2015-12-19)

Bugfixes:
 - fix indentation of template resource. (@chris-rock)
 - Various snippet bugfixes for Rubocop compliance. (@stuartpreston)

## 0.4.2 (2015-11-18)

Features:
 - Initial release to coincide with Microsoft Connect conference.
 - Syntax/keyword highlighting
 - Rubocop linting
 - Snippet support 
 