# Change Log
All notable changes to the AWS CLI Configure extension will be documented in this file.

## [Unreleased]
- Looking for new requirements

## 0.3.0 - (2018-06-11)
### Added
- Allow copying profiles with keys (role_arn & source_profile) in addition to those with keys (aws_access_key_id & aws_secret_access_key)
- When credentials file is updated, add a blank line seperating each section


## 0.2.1 - (2018-06-09)
### Fixed
- Fixed error when setting default profile to a named profile

## 0.2.0 - (2018-06-09)
### Added
- Command: Show [named] profile mapped to [default] in 'credentials'
- Command: Set 'credentials' [default] profile to...
- Command: Copy profile name from 'credentials'...
- Status Bar: Activating extension shows which [named] profile is mapped to [default]
- Status Bar: Clicking profile name in status bar executes command: Set 'credentials' [default] profile to...

### Updated
- Rename command to: Open 'credentials' file
- Rename command to: Open 'config' file
- Rename command to: Open 'credentials' & 'config' files


## 0.0.1 - (2018-06-08)
### Added
- Command: Open credentials file
- Command: Open config file
- Command: Open credentials & config files
- Command: Browse online docs