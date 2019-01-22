'use strict';

jest.mock('fs');
const Utils = require('../../lib/utils');
const fs = require('fs');

describe('Utils Unit test', () => {
    test('write file', () => {
        const filePath = "test";
        const encodedOutput = "output";
        Utils.writeFile(filePath, encodedOutput);
        expect(fs.writeFileSync).toBeCalledWith('test', 'output', 'utf-8');
    });

    test('read file', () => {
        const filePath = "test";
        Utils.readFile(filePath);
        expect(fs.readFileSync).toBeCalledWith('test', 'utf-8');
    });

    test('deep copy', () => {
        const test = {"test": {"test1": 123}};
        let result = Utils.deepCopy(test);
        expect(result).toEqual(test);
    });
});
