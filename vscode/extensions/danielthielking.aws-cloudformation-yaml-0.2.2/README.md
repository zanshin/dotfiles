# [YAML](http://yaml.org/) snippets for AWS [CloudFormation](https://aws.amazon.com/de/cloudformation/) in VS Code

This extension adds some snippets to YAML based files for AWS CloudFormation.

Project located on [Github](https://github.com/dthielking/aws-cloudformation-yaml)

## Overview

* Adds YAML base snippets to your VS Code to get CloudFormation resources
* Adds Json parameter config snippets for CloudFormation

## Extension usage

Following Snippets do provide this extension for YAML files:

* AWSTemplate (Adds a complete template structure)
* Sections
  * Parameter section
    * __Parameter__ (Adds new parameter to parameter section of your template)
  * Metadata section
    * __MetadataParameterGroup__ (Adds new ParameterGroup into Metadata section)
  * __ConditionsSection__ (Adds new Conditions Section into template)
  * Resource section
    * __Resource__ (Adds a new resource)
    * __ResourceWithTemplateUR__ (Adds a resource with TemplateURL)
  * Output section
    * __Output__ (Adds structure of Output)
    * __Export__ (Adds structure of Export for Output)
* Miscellaneous
  * __Tags__ (Add Tag: Key, Value)
  * Intrinsic Functions
    * __!FindInMap__
    * __!GetAtt__
    * __!GetAZs__
    * __!Cidr__
    * __!ImportValue__
    * __!Join__
    * __!Select__
    * __!Split__
    * __!Sub__
    * __!Ref__
  * Condition Functions
    * __!And__
    * __!Equals__
    * __!If__
    * __!Not__
    * __!Or__

Following snippets do provide this extenstion for JSON files:

* __AWSConfig__ (Adds a complete parameter configuration)
* __ParamKey__ (Adds new parameters to configuration file)

## Release Notes

You will find all release notes under following link:
[Release Notes](https://github.com/dthielking/aws-cloudformation-yaml/blob/master/CHANGELOG.md)
