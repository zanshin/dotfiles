'use strict';

jest.mock('../lib/ini');
jest.mock('../lib/utils');
const awsProfileHandler = require('../index');
const Ini = require('../lib/ini');
const Utils = require('../lib/utils');
const path = require('path');
const os = require('os');

let initInstance;
let testingObject;
let addedObject = {
    "happyCase": {
        "aws_access_key_id": "a",
        "aws_secret_access_key": "b"
    },
    "emptyObject": {
    },
    "missingOneKey": {
        "aws_access_key_id": "a",
    },
    "containsOneExtraKey": {
        "aws_access_key_id": "a",
        "aws_secret_access_key": "b",
        "extra": 123
    },
    "wrongKeys": {
        "wrong": "a",
        "keys": "b"
    }
};
let addedObjectAltSchema = {
    "happyCase": {
        "role_arn": "a",
        "source_profile": "b"
    },
    "emptyObject": {
    },
    "missingOneKey": {
        "source_profile": "a",
    },
    "containsOneExtraKey": {
        "role_arn": "a",
        "source_profile": "b",
        "extra": 123
    },
    "wrongKeys": {
        "wrong": "a",
        "keys": "b"
    }
};
let childObject = {
    "default": {
        "key1": "val1",
        "key2": "val2"
    }
};

describe('V2 awsProfileHandler unit test', () => {
    const TEST_STRING = 'test';

    beforeEach(() => {
        testingObject = {
            "default": childObject.default,
            "awesome": {
                "aaron": "that's me"
            }
        };


        Utils.readFile.mockReturnValue(TEST_STRING);
        Ini.decodeIniData.mockReturnValue(testingObject);
        Utils.deepCopy.mockImplementation((object) => {
            return JSON.parse(JSON.stringify(object))
        });
    });

    describe('listProfile', () => {
        it('with default credentials path', () => {
            const defaultFilePath = path.join(os.homedir(), '.aws', 'credentials');
            let result = awsProfileHandler.listProfiles();
            expect(Utils.readFile).toBeCalledWith(defaultFilePath);
            expect(Ini.decodeIniData).toBeCalledWith(TEST_STRING);
            expect(result).toEqual(['default', 'awesome']);
        });
        it('with customized credentials path', () => {
            const customFilePath = "custom/file/path";
            let result = awsProfileHandler.listProfiles(customFilePath);
            expect(Utils.readFile).toBeCalledWith(customFilePath);
            expect(Ini.decodeIniData).toBeCalledWith(TEST_STRING);
            expect(result).toEqual(['default', 'awesome']);
        });

        it('when file is empty return empty array', () => {
            const customFilePath = "custom/file/path";
            Ini.decodeIniData.mockReturnValue({});
            let result = awsProfileHandler.listProfiles(customFilePath);
            expect(Utils.readFile).toBeCalledWith(customFilePath);
            expect(Ini.decodeIniData).toBeCalledWith(TEST_STRING);
            expect(result).toEqual([]);
        });
    });

    describe('getProfileCredentials', () => {
        test('cannot find the profile', () => {
            let result = awsProfileHandler.getProfileCredentials("empty");
            expect(result).toBe(null);
        });

        test('find the profile', () => {
            let result = awsProfileHandler.getProfileCredentials("default");
            expect(result).toEqual(childObject.default);
        });

        it('should throw error if input profile is missing', () => {
            function invalidInput() {
                return awsProfileHandler.getProfileCredentials();
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        });

        it('should throw error if input profile is only white space', () => {
            function invalidInput() {
                return awsProfileHandler.getProfileCredentials("\n\t  ");
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        });

    });

    describe('deleteProfile', () => {
        it('happy case', () => {
            awsProfileHandler.deleteProfile("awesome");
            expect(Ini.encodeIniFormat)
                .toBeCalledWith(childObject);
            expect(Utils.writeFile).toBeCalled();
        });

        it('delete the last object', () => {
            testingObject = {
                "awesome": {
                    "aaron": "that's me"
                }
            };
            awsProfileHandler.deleteProfile("awesome");
            expect(Ini.encodeIniFormat)
                .toBeCalledWith(childObject);
            expect(Utils.writeFile).toBeCalled();
        });

        it('the input profile doesn\'t exist', () => {
            awsProfileHandler.deleteProfile("amazing");
            expect(Ini.encodeIniFormat)
                .toBeCalledWith(childObject);
            expect(Utils.writeFile).toBeCalled();
        });

        it('should throw error if input profile is missing', () => {
            function invalidInput() {
                return awsProfileHandler.deleteProfile();
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        });

        it('should throw error if input profile is only white space', () => {
            function invalidInput() {
                return awsProfileHandler.deleteProfile("\n\t  ");
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        });
    });

    describe('addProfile', () => {
        it ('happy case', () => {
            let expected_result = {
                "default": childObject.default,
                "awesome": {
                    "aaron": "that's me"
                },
                "add": addedObject.happyCase
            };
            awsProfileHandler.addProfile("add", addedObject.happyCase);
            expect(Utils.writeFile).toBeCalled();
            expect(Ini.encodeIniFormat)
                .toBeCalledWith(expected_result);
        });


        it('should throw error if input profile is missing', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile();
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        });

        it('should throw error if input profile is only white space', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile("\n\t  ");
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        });

        it('should throw error if input credentials is missing', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile');
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: credentials cannot be omitted nor empty.');
        });

        it('should throw error if input credentials is empty', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile', addedObject.emptyObject);
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: credentials cannot be omitted nor empty.');
        });

        it('should throw error if input credentials is missing one key', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile', addedObject.missingOneKey);
            }
            expect(invalidInput)
                .toThrowError('Invalid input: credentials schema is invalid.');
        });

        it('should throw error if input credentials has extra keys', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile', addedObject.containsOneExtraKey);
            }
            expect(invalidInput)
                .toThrowError('Invalid input: credentials schema is invalid.');
        });

        it('should throw error if input credentials object has wrong keys', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile', addedObject.wrongKeys);
            }
            expect(invalidInput)
                .toThrowError('Invalid input: credentials schema is invalid.');
        });
    })

    describe('addProfile - alt schema', () => {
        it ('happy case', () => {
            let expected_result = {
                "default": childObject.default,
                "awesome": {
                    "aaron": "that's me"
                },
                "add": addedObjectAltSchema.happyCase
            };
            awsProfileHandler.addProfile("add", addedObjectAltSchema.happyCase);
            expect(Utils.writeFile).toBeCalled();
            expect(Ini.encodeIniFormat)
                .toBeCalledWith(expected_result);
        });


        it('should throw error if input profile is missing', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile();
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        });

        it('should throw error if input profile is only white space', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile("\n\t  ");
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        });

        it('should throw error if input credentials is missing', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile');
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: credentials cannot be omitted nor empty.');
        });

        it('should throw error if input credentials is empty', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile', addedObjectAltSchema.emptyObject);
            }
            expect(invalidInput)
                .toThrowError('Invalid Input: credentials cannot be omitted nor empty.');
        });

        it('should throw error if input credentials is missing one key', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile', addedObjectAltSchema.missingOneKey);
            }
            expect(invalidInput)
                .toThrowError('Invalid input: credentials schema is invalid.');
        });

        it('should throw error if input credentials has extra keys', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile', addedObjectAltSchema.containsOneExtraKey);
            }
            expect(invalidInput)
                .toThrowError('Invalid input: credentials schema is invalid.');
        });

        it('should throw error if input credentials object has wrong keys', () => {
            function invalidInput() {
                return awsProfileHandler.addProfile('profile', addedObjectAltSchema.wrongKeys);
            }
            expect(invalidInput)
                .toThrowError('Invalid input: credentials schema is invalid.');
        });
    })    
});

describe('awsProfileHandler unit test', () => {
    beforeEach(() => {
        testingObject = {
            "default": childObject.default,
            "awesome": {
                "aaron": "that's me"
            }
        };

        Utils.readFile.mockReturnValue(null);
        Ini.decodeIniData.mockReturnValue(testingObject);
        Utils.deepCopy.mockImplementation((object) => {
            return JSON.parse(JSON.stringify(object))
        });
        initInstance = new awsProfileHandler('amazing/package');
    });

    describe('test instance setup (constructor)', () => {
        it('default path', () => {
            const defaultFilePath = path.join(os.homedir(), '.aws', 'credentials');
            new awsProfileHandler();
            expect(Utils.readFile).toBeCalledWith(defaultFilePath);
            expect(Ini.decodeIniData).toBeCalled();
        });

        it('custom file path', () => {
            const customFilePath = "custom/file/path";
            new awsProfileHandler(customFilePath);
            expect(Utils.readFile).toBeCalledWith(customFilePath);
            expect(Ini.decodeIniData).toBeCalled();
        });

        it('has decode error', () => {
            Utils.readFile.mockReturnValue(null);
            Ini.decodeIniData.mockImplementation(() => {
                throw new Error();
            });
            let errorThrowingFunction = () => {
                new awsProfileHandler();
            };
            expect(errorThrowingFunction).toThrow();
        });
    });

    test('listProfile', () => {
        let result = initInstance.listProfiles();
        expect(result).toEqual(['default', 'awesome']);
    });

    describe('getProfileCredentials', () => {
        test('cannot find the profile', () => {
            let result = initInstance.getProfileCredentials("empty");
            expect(result).toBe(null);
        });

        test('find the profile', () => {
            let result = initInstance.getProfileCredentials("default");
            expect(result).toEqual(childObject.default);
        });
    });

    test('deleteProfile', () => {
        initInstance.deleteProfile("awesome");
        expect(Ini.encodeIniFormat)
           .toBeCalledWith(childObject);
        expect(Utils.writeFile).toBeCalled();
    });

    test('addProfile', () => {
        let expected_result = {
            "default": childObject.default,
            "awesome": {
                "aaron": "that's me"
            },
            "add": addedObject.add
        };
        initInstance.addProfile("add", addedObject.add);
        expect(Utils.writeFile).toBeCalled();
        expect(Ini.encodeIniFormat)
            .toBeCalledWith(expected_result);
    })
});