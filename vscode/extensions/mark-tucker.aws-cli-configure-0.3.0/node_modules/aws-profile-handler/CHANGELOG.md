# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [2.0.3] - 2018-05-04
##### May the fourth be with you!

### Changed
- Remove aws keys check for decoder, the user can put arbitrary key/value pairs in a profile.


## [2.0.2] - 2018-04-20
### Changed
- Encoder will not add line breaks, it matches with aws-cli behaviour.

### Added
- Validation for the correct keys during decode the INI file.

## [2.0.1] - 2018-02-26
### Added
- Validator: Input profile name cannot be white space, '\n', '\t', etc...
- Validator: Input profile cannot be missing.
- Validator: Credential schema has to be valid.

### Changed
- If the file is empty, the package returns an empty array instead of throwing an error.


## [2.0.0] - 2018-02-16
### Added
- Static methods: listProfiles, getProfile, deleteProfile, and addProfile.
- CHANGELOG.md

### Changed
- Instructions in README.md.

### Deprecated
- Initiation of aws-profile-handler instance. 
- All instance methods: listProfiles, getProfile, deleteProfile, and addProfile.

[2.0.3]: https://github.com/novking/aws-profile-handler/compare/v2.0.2...v2.0.3
[2.0.2]: https://github.com/novking/aws-profile-handler/compare/v2.0.1...v2.0.2
[2.0.1]: https://github.com/novking/aws-profile-handler/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/novking/aws-profile-handler/compare/v1.1.0...v2.0.0
[2.0.1]: https://github.com/novking/aws-profile-handler/compare/v2.0.0...v2.0.1

