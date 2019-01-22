'use strict';

const Ini = require('../../lib/ini');

describe('Ini module unit test', () => {
    const iniObjectFormat = {
        'default': {
            'aws_access_key_id': '123',
            'aws_secret_access_key': '321',
            'region': 'us-east-1'
        },
        'test': {
            'aws_access_key_id': '12345',
            'aws_secret_access_key': '12345'
        }
    };

    const iniTextFormat =
        "[default]\n" +
        "aws_access_key_id=123\n" +
        "aws_secret_access_key=321\n" +
        "region=us-east-1\n" +
        "\n" +
        "[test]\n" +
        "aws_access_key_id=12345\n" +
        "aws_secret_access_key=12345" +
        "\n";

    const withCommentsIniTextFormat =
        "# start comments\n" +
        "[default]\n" +
        "aws_access_key_id=123 ;inline comments\n" +
        "aws_secret_access_key=321 # inline comments\n" +
        "region=us-east-1 \n" +
        "# ending comments\n" +
        "\r\t\n" +
        "[test]\n" +
        "aws_access_key_id=12345\n" +
        "aws_secret_access_key=12345";


    const incompeletedKeyPair =
        "[default]\n" +
        "aws_access_key_id=123\n" +
        "aws_secret_access_key=\n" +
        "[test]\n" +
        "aws_access_key_id=12345\n" +
        "aws_secret_access_key=12345\n";

    const nestedSession =
        "[default]\n" +
        "[nested]\n" +
        "aws_access_key_id=123\n" +
        "aws_secret_access_key=\n" +
        "[test]\n" +
        "aws_access_key_id=12345\n" +
        "aws_secret_access_key=12345\n";

    const emptyFile = "";

    const whiteSpaceFile = "\n\t\r   \n";

    const emptyInitObject = {};


    describe('encodeIniFormat', () => {
        it('happy case', () => {
            let encodedResult = Ini.encodeIniFormat(iniObjectFormat);
            expect(encodedResult).toEqual(iniTextFormat);
        });

        it('empty object', () => {
            let encodedResult = Ini.encodeIniFormat(emptyInitObject);
            expect(encodedResult).toEqual("");
        });
    });


    describe('decodeInitData', () => {
        it('happy case', () => {
            let decodedResult = Ini.decodeIniData(iniTextFormat);
            expect(decodedResult).toEqual(iniObjectFormat);
        });

        it('with comments', () => {
            let decodedResult = Ini.decodeIniData(withCommentsIniTextFormat);
            expect(decodedResult).toEqual(iniObjectFormat);
        });

        it('incomplete key-value pair error', () => {
            function invalidContent() {
                return Ini.decodeIniData(incompeletedKeyPair);
            }
            expect(invalidContent)
                .toThrowError('Invalid AWS credential file. Incomplete key/value pair');
        });

        it('nested sessions error', () => {
            function invalidContent() {
                return Ini.decodeIniData(nestedSession);
            }
            expect(invalidContent)
                .toThrowError('Invalid AWS credential file. Cannot have nested sessions');
        });

        it('empty file should return empty object', () => {
            let decodedResult = Ini.decodeIniData(emptyFile);
            expect(decodedResult).toEqual({});
        });

        it('\'white spaces only\' file should return empty object', () => {
            let decodedResult = Ini.decodeIniData(whiteSpaceFile);
            expect(decodedResult).toEqual({});
        });
    });

    describe('_emptyCheck', () => {
        it('should return true if the input array is empty', () => {
            let input_array = [];
            expect(Ini._emptyCheck(input_array)).toEqual(true);
        });

        it('should return false if the input array has at least one non-whitespace', () => {
            let input_array = ['\n\n', '\t', '  ', 'done'];
            expect(Ini._emptyCheck(input_array)).toEqual(false);
        });

        it('should return true if the input array only has whitespace array', () => {
            let input_array = ['\n\n', '\t', '  ', ''];
            expect(Ini._emptyCheck(input_array)).toEqual(true);
        });
    })
});

