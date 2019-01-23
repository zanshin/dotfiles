# AWS CLI Configure for Visual Studio Code

The AWS CLI Configure extension allows you to quickly access AWS CLI information and docs from Visual Studio Code.


## Features

The extension adds commands for the following:
* Open 'credentials' file
* Open 'config' file
* Open 'credentials' & 'config' files
* Browse the online docs
* Show [named] profile mapped to [default] in 'credentials'
* Set 'credentials' [default] profile to...
* Copy profile name from 'credentials'...

### Commands

![Command List](https://github.com/rmtuckerphx/aws-cli-configure/raw/master/images/commands.png)

### Copy profile name
![Copy Profile](https://github.com/rmtuckerphx/aws-cli-configure/raw/master/images/copy-profile.png)
Now the name is on the clipboard. Paste away!

### Show named profile mapped to default
![Show Mapped Profile](https://github.com/rmtuckerphx/aws-cli-configure/raw/master/images/statusbar-mapped-profile.png)

- Saving the 'credentials' file from VSCode or setting the default profile updates the status bar. 
- Click the item in the status bar to set the [default] profile to a [named] profile.


### Set default profile
![Set Default Profile](https://github.com/rmtuckerphx/aws-cli-configure/raw/master/images/set-default-profile.png)
To be able to set the [default] profile to a named profile, in the 'credentials' file each profile section must contain only two entries following one of these formats:

- aws_access_key_id & aws_secret_access_key
- role_arn & source_profile

This sample shows the `master-profile` in one account that uses an access key and secret and three role profiles each in a seperate account that references the `master-profile` as the source profile.

The [default] profile is set to `qa-profile`.

![Sample Credentials File with Supported Sections](https://github.com/rmtuckerphx/aws-cli-configure/raw/master/images/section-schema.png)

Put `region` and other entries in the `config` file.
If a section in `credentials` includes more than the required two entries and you try to set the default profile to it, you will get the following error:

![Invalid schema error](https://github.com/rmtuckerphx/aws-cli-configure/raw/master/images/invalid-schema-error.png)

 
## Known Issues

No known issues

## Release Notes

See Changelog

## License
This software is released under [MIT License](http://www.opensource.org/licenses/mit-license.php)
© [Mark Tucker (@rmtuckerphx)](https://github.com/rmtuckerphx) & Contributors

## Review
Feedback and contributions welcome. Please leave a [review](https://marketplace.visualstudio.com/items?itemName=mark-tucker.aws-cli-configure#review-details).