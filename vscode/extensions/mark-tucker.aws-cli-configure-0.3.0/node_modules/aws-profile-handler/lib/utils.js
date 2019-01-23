'use strict';

const fs = require('fs');

class Utils {
    static writeFile(filePath, encodedOutput) {
        fs.writeFileSync(filePath, encodedOutput, 'utf-8');
    }

    static deepCopy(object) {
        return JSON.parse(JSON.stringify(object));
    }

    static readFile(filePath) {
        return fs.readFileSync(filePath, 'utf-8');
    }
}

module.exports = Utils;