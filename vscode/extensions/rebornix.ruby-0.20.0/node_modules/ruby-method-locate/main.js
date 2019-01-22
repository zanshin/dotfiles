'use strict';


const positionalise = require('./lib/positionalise'),
    parser = require('./lib/parse'),
    fs = require('fs');


module.exports = function parse(fileName) {
    return new Promise((resolve, reject) => {
        fs.readFile(fileName, (err, data) => {
            if (err) return reject(err);
            const stringData = data.toString();
            let result = parser(stringData);
            if (!result) return resolve();
            delete result.end;
            if (Object.keys(result).length) {
                resolve(positionalise(stringData, result));
            } else resolve();
        });
    });
};