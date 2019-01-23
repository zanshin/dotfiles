'use strict';

class Ini {
    static decodeIniData(rawData) {
        let currentSection;
        let map = {};
        let uniqueSectionFlag = false;
        let lines = rawData.split(/\r?\n/);

        if (Ini._emptyCheck(lines)) return {};


        lines.forEach((line) => {
            // this regex will remove comments after
            // each aws profile
            line = line.split(/(^|\s)[;#]/)[0].trim();
            if (!line) return;

            let section = line.match(/^\s*\[([^\[\]]+)\]\s*$/);
            if (section && uniqueSectionFlag) {
                throw new Error('Invalid AWS credential file. Cannot have nested sessions');
            }
            else if (section) {
                currentSection = section[1];
                uniqueSectionFlag = true;
            }
            else{
                let item = line.match(/^\s*(.+?)\s*=\s*(.+?)\s*$/);

                if (item) {
                    map[currentSection] = map[currentSection] || {};
                    map[currentSection][item[1]] = item[2];
                    uniqueSectionFlag = false;
                } else {
                    throw new Error('Invalid AWS credential file. Incomplete key/value pair');
                }
            }
        });
        return map;
    }

    static encodeIniFormat(iniObject) {
        function _flattenObject(object) {
            let listObject = Object.keys(object).reduce((result, key) => {
                result.push(key + "=" + object[key]);
                return result;
            }, []);
            return listObject;
        }

        let dividedIntoListOfObjects = Object.keys(iniObject).map((session) => {
            let newObject = {};
            newObject[session] = iniObject[session];
            return newObject;
        });

        let encodedIniContentList = dividedIntoListOfObjects.reduce(
            (iniContentList, sessionObject) => {
                let sessionName = Object.keys(sessionObject)[0];
                iniContentList.push("[" + sessionName + "]");

                let listChild = _flattenObject(sessionObject[sessionName]);
                return iniContentList.concat(listChild, '');
            }, []);
        return encodedIniContentList.join('\n');
    }

    static _emptyCheck(array) {
        if (array.length === 0) return true;
        for (let item of array) {
            if (item.trim().length !== 0) {
                return false;
            }
        }
        return true;
    }
}

module.exports = Ini;