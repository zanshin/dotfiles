# aws-profile-handler
Simply tool for extracting and editing the .aws/credentials.
You can add, get, list, and delete profile(s) synchronously, no 3p dependencies introduced.

[![Build Status](https://travis-ci.org/novking/aws-profile-handler.svg?branch=master)](https://travis-ci.org/novking/aws-profile-handler)
[![Coverage Status](https://coveralls.io/repos/github/novking/aws-profile-handler/badge.svg?branch=master)](https://coveralls.io/github/novking/aws-profile-handler?branch=master)
[![GitHub license](https://img.shields.io/github/license/novking/aws-profile-handler.svg)](https://github.com/novking/aws-profile-handler/blob/master/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/novking/aws-profile-handler.svg)](https://github.com/novking/aws-profile-handler/issues)
[![Maintainability](https://api.codeclimate.com/v1/badges/d3c0ab7cf85434db1e2c/maintainability)](https://codeclimate.com/github/novking/aws-profile-handler/maintainability)
[![dependencies Status](https://david-dm.org/novking/aws-profile-handler/status.svg)](https://david-dm.org/novking/aws-profile-handler)
[![npm version](https://badge.fury.io/js/aws-profile-handler.svg)](https://badge.fury.io/js/aws-profile-handler)

## How do I install it?

Install it into your package

```bash
npm install aws-profile-handler --save
```

## Add a profile

```javascript
let valid_credential_object = {
        "aws_access_key_id": "123",
        "aws_secret_access_key": "456"
};

let awsProfiler = require('aws-profile-handler');

// AWS credentials file path is optional as the last parameter. Default to ~/.aws/credentials
awsProfiler.addProfile('awesomeProfileName', valid_credential_object); 
awsProfiler.addProfile('awesomeProfileName', valid_credential_object, 'file/path/to/aws/credentials'); 


// .aws/credentials 
[awesomeProfileName]
aws_access_key_id=123
aws_secret_access_key=456
```

## Get a profile's credentials

```javascript

let awsProfiler = require('aws-profile-handler');

// AWS credentials file path is optional as the last parameter. Default to ~/.aws/credentials
awsProfiler.getProfileCredentials('awesomeProfileName');
awsProfiler.getProfileCredentials('awesomeProfileName', 'file/path/to/aws/credentials');


// return 'null' if profile doesn't exist
// return an object with 'aws_access_key_id' and 'aws_access_key_id'
{
    "aws_access_key_id": "123",
    "aws_secret_access_key": "456"
}
```

## List profiles

```javascript
let awsProfiler = require('aws-profile-handler');

// AWS credentials file path is optional as the last parameter. Default to ~/.aws/credentials
awsProfiler.listProfiles();
awsProfiler.listProfiles('file/path/to/aws/credentials');

// return a list of all the profiles' name
// ['awesomeProfileName', 'something', 'else', 'if', 'exists'];
```

## Delete a profile

```javascript
let awsProfiler = require('aws-profile-handler');

// AWS credentials file path is optional as the last parameter. Default to ~/.aws/credentials
awsProfiler.deleteProfile('lameProfileName');
awsProfiler.deleteProfile('lameProfileName', 'file/path/to/aws/credentials');
```
## Error
Four customized errors would be thrown.
1. If format is invalid.
```javascript
// error.message:
'Invalid AWS credential file. Cannot have nested sessions'
```
2. If one or more values are missing.
```javascript
// .aws/credentials
[badProfile]
aws_access_key_id=
aws_secret_access_key=idIsMissing

// error.message
'Invalid AWS credential file. Incomplete key/value pair'

```
3. If input credentials object is invalid.
```javascript
let missingOneKey = {
    aws_access_key_id: 1
}

let haveOneExtraKey = {
    aws_access_key_id: 1,
    aws_secret_access_key: 2,
    extra: 3
}

let wrongName = {
    aws_secret_access_key: 2,
    extra: 3
}

// error.message
'Invalid input: credentials schema is invalid.'
```
4. If require input parameters are missing.
```javascript
awsProfileHandler.addProfile();
// error.message
'Invalid Input: profile name cannot be omitted nor only contains white spaces.'

awsProfileHandler.addProfile('profile');
// error.message
'Invalid Input: credentials cannot be omitted nor empty.'
```

### Note:
Version 1.X.X is deprecated, the last V1 update was 1.1.0.