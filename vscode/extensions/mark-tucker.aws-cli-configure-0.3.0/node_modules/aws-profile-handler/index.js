'use strict';

const path = require('path');
const os = require('os');
const Ini = require('./lib/ini');
const Utils = require('./lib/utils');
const defaultFilePath = path.join(os.homedir(), '.aws', 'credentials');

class awsProfileHandler {
    /**
     * @deprecated
     * @param filePath
     */
    constructor(filePath) {
        const defaultFilePath = path.join(os.homedir(), '.aws', 'credentials');
        this.filePath = filePath || defaultFilePath;
        this.profileObject = Ini.decodeIniData(Utils.readFile(this.filePath));
    }

    /**
     * @deprecated
     * @return {Array}
     */
    listProfiles() {
        return Object.keys(this.profileObject);
    }

    /**
     * @deprecated
     * @param profile
     * @return {*}
     */
    getProfileCredentials(profile) {
        let credentials = this.profileObject[profile];
        if (!credentials) return null;
        else return Utils.deepCopy(credentials);
    }

    /**
     * @deprecated
     * @param profile
     */
    deleteProfile(profile) {
        let outputProfileObject = Utils.deepCopy(this.profileObject);
        delete outputProfileObject[profile];
        let encodedProfile = Ini.encodeIniFormat(outputProfileObject);
        Utils.writeFile(this.filePath, encodedProfile);
    }

    /**
     * @deprecated
     * @param profile
     * @param credentials
     */
    addProfile(profile, credentials) {
        let outputProfileObject = Utils.deepCopy(this.profileObject);
        outputProfileObject[profile] = credentials;
        let encodedProfile = Ini.encodeIniFormat(outputProfileObject);
        Utils.writeFile(this.filePath, encodedProfile);
    }

    static listProfiles(filePath) {
        let credentialPath = filePath || defaultFilePath;
        let profileObject = Ini.decodeIniData(Utils.readFile(credentialPath));

        return Object.keys(profileObject);
    }

    static getProfileCredentials(profile, filePath) {
        if (!profile || profile.trim().length === 0) {
            throw new Error('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        }
        let credentialPath = filePath || defaultFilePath;
        let profileObject = Ini.decodeIniData(Utils.readFile(credentialPath));

        let credentials = profileObject[profile];
        if (!credentials) return null;
        else return Utils.deepCopy(credentials);
    }

    static deleteProfile(profile, filePath) {
        if (!profile || profile.trim().length === 0) {
            throw new Error('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        }
        let credentialPath = filePath || defaultFilePath;
        let profileObject = Ini.decodeIniData(Utils.readFile(credentialPath));

        // profileObject will never be 'null'. worst case is {}
        let outputProfileObject = Utils.deepCopy(profileObject);
        delete outputProfileObject[profile];
        let encodedProfile = Ini.encodeIniFormat(outputProfileObject);
        Utils.writeFile(credentialPath, encodedProfile);
    }

    static addProfile(profile, credentials, filePath) {
        if (!profile || profile.trim().length === 0) {
            throw new Error('Invalid Input: profile name cannot be omitted nor only contains white spaces.');
        }

        if (!credentials || Object.keys(credentials).length === 0) {
            throw new Error('Invalid Input: credentials cannot be omitted nor empty.');
        }

        if (Object.keys(credentials).length !== 2 ||
            !this.isValidSchema(credentials) &&
            !this.isValidAltSchema(credentials)) {
            throw new Error('Invalid input: credentials schema is invalid.');
        }

        let credentialPath = filePath || defaultFilePath;
        let profileObject = Ini.decodeIniData(Utils.readFile(credentialPath));

        let outputProfileObject = Utils.deepCopy(profileObject);
        outputProfileObject[profile] = credentials;
        let encodedProfile = Ini.encodeIniFormat(outputProfileObject);
        Utils.writeFile(credentialPath, encodedProfile);
    }

    static isValidSchema(credentials) {
        return (credentials.hasOwnProperty('aws_access_key_id') && credentials.hasOwnProperty('aws_secret_access_key'))
    }

    static isValidAltSchema(credentials) {
        return (credentials.hasOwnProperty('role_arn') && credentials.hasOwnProperty('source_profile'))
    }    
}
module.exports = awsProfileHandler;


