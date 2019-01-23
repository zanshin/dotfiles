# Change Log

All notable changes to the "aws-cloudformation-yaml" extension will be documented in this file.

Check [Keep a Changelog](http://keepachangelog.com/) for recommendations on how to structure this file.

## [0.2.2] - 2018.03.29

### Added

* Intrinsic function snippets
  * !Cidr

## [0.2.1] - 2018.03.29

### Added

* Added jump marker to output section of AWSTemplate Snippet

### Changed

* Fixed Bug with !Sub command
  * After typing Sub completion result was !Sub: colon is wrong
* Changed description of AWSTemplate snippet

## [0.2.0]

* ???

## [0.1.2] - 2017.10.19

### Added

* Conditions section now as snippet available
* Intrinsic function snippets
  * !GetAZs
  * !Select
  * !Split
* Intrinsic conditions
  * !And
  * !Equals
  * !If
  * !Not
  * !Or

### Changed

* Order of internal snippets
* README.md

## [0.1.1] - 2017-10-18

### Fixed

* Missing colons on Output and Export Snippet

## [0.1.0] - 2017-10-17

### Fixed

* Wrong indentions in snippets

### Added

* CloudFormation intrinsic function !Sub

## [0.0.9] - 2017-10-11

### Added

* New YAML snippet "MetadataParameterGroup", adds new ParameterGroup to CloudFormation::Interface

## [0.0.8] - 2017-10-11

### Changed

* Changed Type handling for new resources, now you do not have to specify double colons
* Changed cursor position after last placeholders

## [0.0.7] - 2017-10-11

### Added

* Added new json language snippet.
* Json snippet that will create new configuration file in json with on Parameter section.
* Snippet that generates ParameterKey,ParameterValue in json files

## [0.0.6] - 2017-10-11

### Changed

* Make Extension available for Version 1.14.x

## [0.0.5] - 2017-10-09

### Added

* Github URL to extension in README

## [0.0.4] - 2017-10-09

### Fixed

* Parameter snippets type selection

## [0.0.3] - 2017-10-09

### Added

Brief documentation to README.md

## [0.0.2] - 2017-10-09

## Removed

* Default explanation about using snippets

### Fixed

* Fixed some spelling features
* Fixed indention in snippets structure

## [0.0.1] - 2017-10-08
- Initial release
