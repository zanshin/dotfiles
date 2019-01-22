// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require('vscode');
const path = require('path');
const os = require('os');
const opn = require('opn');
const fs = require('fs');
const profileHandler = require('aws-profile-handler');
const hash = require('object-hash');
const copyPaste = require("copy-paste");
const uniqid = require('uniqid');

const DEFAULT_PROFILE = 'default';
let statusBar;

function openCredentialsFile(previewFlag = true) {

    openFile(path.join(os.homedir(), '.aws', 'credentials'), previewFlag);

}

function openConfigFile(previewFlag = true) {

    openFile(path.join(os.homedir(), '.aws', 'config'), previewFlag);
}

function openBothFiles() {

    openCredentialsFile(false);
    openConfigFile(false);

}

function openFile(filePath, previewFlag) {

    if (fs.existsSync(filePath)) {
        vscode.workspace.openTextDocument(filePath)
            .then(doc => vscode.window.showTextDocument(doc, { preview: previewFlag }))
    }
    else {
        vscode.window.showInformationMessage(`File '${filePath}' does not exist.`);
    }

}

function openOnlineDocs() {

    opn('https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html');

}

function getTooltipMessage() {

    const mappedProfile = getDefaultProfileSetTo();
    let message = '';

    switch (mappedProfile) {
        case '<none>':
            message = `No [default] profile in 'credentials'`;
            break;

        case DEFAULT_PROFILE:
            message = `No [named] profile mapped to [default] in 'credentials'`;
            break;

        default:
            message = `The [${mappedProfile}] profile is mapped to [default] in 'credentials'`
            break;
    }

    return message;
}

function showDefaultProfileMapCredentials() {

    updateStatus(statusBar);

}

function getSortedProfilesCredentials(includeDefaultProfile = true) {

    const credentialsFile = path.join(os.homedir(), '.aws', 'credentials');
    let result = [];

    if (fs.existsSync(credentialsFile)) {

        // listProfile will check if file is valid. If it's not valid,
        // no need to proceed, just callback the error.
        try {
            // if the credential file is empty, CLI will name the first profile as 'default'
            const profiles = profileHandler.listProfiles();

            if (includeDefaultProfile === false) {
                const index = profiles.indexOf(DEFAULT_PROFILE);

                if (index > -1) {
                    profiles.splice(index, 1);
                }
            }

            result = profiles.sort();

        } catch (error) {
            vscode.window.showWarningMessage(`File '${credentialsFile}' is not valid.`);
            console.log(error);
        }

    }
    else {
        vscode.window.showInformationMessage(`File '${credentialsFile}' does not exist.`);
    }

    return result;
}

function updateStatus(statusBar) {

    if (statusBar) {

        const text = getDefaultProfileSetTo();
        if (text) {
            statusBar.text = '$(terminal) AWS CLI: ' + text;
            statusBar.tooltip = getTooltipMessage();
        }

        if (text) {
            statusBar.show();
        } else {
            statusBar.hide();
        }
    }
}

function getDefaultProfileSetTo() {

    // if there is no default profile or named profile, then show <none>
    let text = '<none>';

    const profiles = getSortedProfilesCredentials();

    const hasDefault = profiles.includes(DEFAULT_PROFILE);

    if (hasDefault) {
        // if there is a default profile, show it 
        text = DEFAULT_PROFILE;
    }

    if (hasDefault && profiles.length > 1) {

        const defaultProfile = profileHandler.getProfileCredentials(DEFAULT_PROFILE);

        if (defaultProfile) {

            profiles.forEach(profile => {

                if (profile !== DEFAULT_PROFILE) {
                    const candidateProfile = profileHandler.getProfileCredentials(profile);

                    if (hash(defaultProfile) === hash(candidateProfile)) {

                        // if there is a named profile that has exactly the same
                        // object keys and values (ie hash) as a named profile, show it
                        text = profile;
                    }
                }
            });

        }


    }


    return text;

}

// async function setDefaultProfileToCredentials(statusBar) {
async function setDefaultProfileToCredentials() {

    const profiles = getSortedProfilesCredentials(false);
    const newProfile = await vscode.window.showQuickPick(profiles, { placeHolder: `Select the [named] profile to set as the [default] profile in the 'credentials' file.` });

    if (newProfile) {

        const message = `[default] profile in 'credentials' file set to: '${newProfile}'.`;
        console.log(message);

        const newProfileData = profileHandler.getProfileCredentials(newProfile);

        const mappedProfile = getDefaultProfileSetTo();


        if (mappedProfile === '<none>') {
            //add new [default] profile using values from mappedProfile       
            profileHandler.addProfile(DEFAULT_PROFILE, newProfileData);
        }
        else {
            const defaultProfileData = profileHandler.getProfileCredentials(DEFAULT_PROFILE);

            if (mappedProfile === DEFAULT_PROFILE) {
                //add new profile zzz-default-?
                const generatedName = uniqid('zzz-default-');

                profileHandler.addProfile(generatedName, defaultProfileData);

                const message = `The [default] profile was renamed to ${generatedName}. Rename or delete this profile.`;
                vscode.window.showInformationMessage(message);
            }

            //delete default profile
            profileHandler.deleteProfile(DEFAULT_PROFILE);

            //add new [default] profile using values from mappedProfile
            profileHandler.addProfile(DEFAULT_PROFILE, newProfileData);

        }

        updateStatus(statusBar);
    }

}

async function copyProfileNameCredentials() {

    const profiles = getSortedProfilesCredentials(true);
    const selectedProfile = await vscode.window.showQuickPick(profiles, { placeHolder: `Select profile name.` });

    if (selectedProfile) {
        copyPaste.copy(selectedProfile, () => {
            vscode.window.setStatusBarMessage(`'${selectedProfile}' copied to clipboard.`, 10000);
        });
    }

}

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed

function activate(context) {

    statusBar = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left);
    statusBar.command = 'aws-cli.set-default-profile.credentials';
    context.subscriptions.push(statusBar);
    updateStatus(statusBar);

    context.subscriptions.push(vscode.commands.registerCommand('aws-cli.open.credentials', openCredentialsFile));
    context.subscriptions.push(vscode.commands.registerCommand('aws-cli.open.config', openConfigFile));
    context.subscriptions.push(vscode.commands.registerCommand('aws-cli.open.both', openBothFiles));
    context.subscriptions.push(vscode.commands.registerCommand('aws-cli.browse.docs', openOnlineDocs));

    context.subscriptions.push(vscode.commands.registerCommand('aws-cli.default.map.credentials', showDefaultProfileMapCredentials));
    context.subscriptions.push(vscode.commands.registerCommand('aws-cli.set-default-profile.credentials', setDefaultProfileToCredentials));
    context.subscriptions.push(vscode.commands.registerCommand('aws-cli.copy.profile.credentials', copyProfileNameCredentials));


    context.subscriptions.push(vscode.workspace.onDidSaveTextDocument((doc) => {
        const credentialsFile = path.join(os.homedir(), '.aws', 'credentials').toLowerCase();

        if (doc.fileName.toLowerCase() === credentialsFile) {
            updateStatus(statusBar);
        }
    }));

};



// this method is called when your extension is deactivated
function deactivate() {
}



exports.activate = activate;
exports.deactivate = deactivate;