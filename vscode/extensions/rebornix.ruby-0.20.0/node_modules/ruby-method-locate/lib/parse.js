'use strict';

const util = require('util');

const Entries = require('./entries');

const _nb_white = '\t ';
const _eol = '\r\n;';
const _white = _nb_white + _eol;

const _word_end = '[(#<';
const _defEnd = _white + _word_end;

function skipWhite(buffer, os) {
    let ch;
    while ((ch = buffer[os]) && ~_white.indexOf(ch)) os++;
    return os;
}

function skipNonWhite(buffer, os) {
    // if the first character is a word end, skip it and try again
    // this is required for shitty HEREDOCs
    if (~_word_end.indexOf(buffer[os])) {
        return os+1;
    }
    let ch;
    while ((ch = buffer[os]) && !~_white.indexOf(ch) && !~_word_end.indexOf(ch)) os++;
    return os;
}

function Name(buffer, os) {
    let ch;
    while ((ch = buffer[os]) && !~_defEnd.indexOf(ch)) os++;
    return os;
}

const _nameEnd = _nb_white + ',';

function NameList(buffer, os) {
    let ch;
    let start = os;
    //find the line end, then
    while ((ch = buffer[os]) && !~_eol.indexOf(ch) && ch !== '#') os++;
    let end = os;
    let names = [];
    os = start;
    while (os < end) {
        while (os < end && (ch = buffer[os]) && ~_nameEnd.indexOf(ch)) os++;
        start = os;
        while (os < end && (ch = buffer[os]) && !~_nameEnd.indexOf(ch)) os++;
        names.push(buffer.slice(start, os));
    }
    names.end = os;
    return names;
}

function Include(entry, buffer, os) {
    os += entry.length;
    let names = NameList(buffer, os);
    let rtn = {
        include: names,
        end: names.end
    };
    delete names.end;
    return rtn;
}

function Arguments(buffer, os) {
    //if we have a bracket, find the other bracket
    let ch = buffer[os];
    if (ch === '(') {
        os++;
        let count = 1;
        while ((ch = buffer[os]) && count) {
            if (ch === '#') os = Comment(ch, buffer, os).end;
            else if (~'"`\''.indexOf(ch)) os = Strings(ch, buffer, os).end;
            else if (ch === '(') count++;
            else if (ch === ')') count--;
            os++;
        }
    }
    return {
        end: os
    };
}

function Method(entry, buffer, os) {
    os += entry.length;
    os = skipWhite(buffer, os);
    let posn = os;
    let end = Name(buffer, os);
    const name = buffer.slice(os, end).toString();

    os = end;
    //get any arguments
    const args = Arguments(buffer, os);

    let inner = parse(buffer, os);
    end = inner.end;
    delete inner.end;
    inner.posn = posn;
    let result = {
        end
    };
    if (name.startsWith('self.')) return {
        end,
        classMethod: {
            [name.slice(5)]: inner
        }
    };

    return {
        end,
        method: {
            [name]: inner
        }
    };
}

function Module(entry, buffer, os) {
    os += entry.length;
    os = skipWhite(buffer, os);
    let singleton = false;
    // if it's a singleton
    if (buffer[os] === '<' && buffer[os + 1] === '<') {
        singleton = true;
        os = skipWhite(buffer, os + 2);
    }
    let posn = os;
    let end = Name(buffer, os);
    let name = buffer.slice(os, end);
    os = end;
    let inner = parse(buffer, os);
    end = inner.end;
    delete inner.end;
    inner.posn = posn;
    let result = {};
    if (singleton) {
        if (name === 'self') {
            result.classMethod = inner.method;
        }
        //everything else is not of interest
    } else {
        os = skipWhite(buffer, os);
        if (buffer[os] === '<') {
            //inherit
            os = skipWhite(buffer, os + 1);
            let end2 = Name(buffer, os);
            //there can be only one:
            inner.inherit = buffer.slice(os, end2);
        }
        let parts = name.split('::');
        name = parts.pop();
        let nest = {
            [entry]: {
                [name]: inner
            }
        };
        if (parts.length) {
            nest = parts.reduce((d, n) => {
                let dd = {
                    module: {
                        [n]: d
                    },
                    posn
                };
                return dd;
            }, nest);
        }
        result = nest;
    }
    result.end = end;
    return result;
}

function Block(entry, buffer, os) {
    os += entry.length;
    let endSearch = parse(buffer, os);
    return {
        end: endSearch.end
    };
}

function Alias(entry, buffer, os) {
    os += entry.length;
    let names = NameList(buffer, os);
    if (!names[0] || ~'$@'.indexOf(names[0][0])) return {
        end: names.end
    };
    if (names[0][0] === ':') names[0] = names[0].slice(1);
    // we only actually care about the first name
    return {
        method: {
            [names[0]]: {
                posn: os
            }
        },
        end: names.end
    };
}

function MethodAlias(entry, buffer, os) {
    os += entry.length;
    let names = NameList(buffer, os);
    if (names.length === 0) return {
        end: names.end
    };
    if (names[0][0] !== ':') return {
        end: names.end
    };
    // we only actually care about the first name
    return {
        end: names.end,
        method: {
            [names[0].slice(1)]: {
                posn: os
            }
        }
    };
}

function Comment(entry, buffer, os) {
    let ch;
    while ((ch = buffer[os]) && !~'\r\n'.indexOf(ch)) os++;
    return {
        end: os
    };
}

function Strings(entry, buffer, os) {
    const del = buffer[os];
    os++;
    let ch;
    while ((ch = buffer[os]) && ch !== del) {
        // '\' skip the next character
        if (ch === '\\') os++;
        os++;
    }
    os++;
    return {
        end: os
    };
}

const assignment = '=+-*/&|^<>';

// Can control a preceeding block, OR be the RHS of an assignment
function ConditionAssignBlock(entry, buffer, os) {
    // find out if there's anything before it on the same line. If there is,
    // and it's not something that would make this part of an assignment then
    // it's not a block at all, just set the exit at the end of the line.
    let ch;
    let ros = os - 1;
    while ((ch = buffer[ros]) && ~_nb_white.indexOf(ch)) ros--;
    // console.log("Now at:", ch.charCodeAt(0))
    // if there is, and it's not an assignment then it's
    // not a block at all, just set the exit at the end of the line or
    // the start of a comment
    if (!~assignment.indexOf(ch) && !~_eol.indexOf(ch)) {
        os += entry.length;
        while ((ch = buffer[os]) && !~_eol.indexOf(ch) && ch !== '#') os++;
        return {
            end: os
        };
    }
    // It's just a block then
    return Block(entry, buffer, os);
}

// Can control a preceeding block
function ConditionBlock(entry, buffer, os) {
    // find out if there's anything before it on the same line. If there is,
    // and it's not a semi colon
    // it's not a block at all, just set the exit at the end of the line.
    let ch;
    let ros = os - 1;
    while ((ch = buffer[ros]) && ~_nb_white.indexOf(ch)) ros--;

    // if there is and it's not a ';' then it's not a block at all,
    // just set the exit at the end of the line
    if (~_eol.indexOf(ch)) {
        os += entry.length;
        while ((ch = buffer[os]) && !~_eol.indexOf(ch) && ch !== '#') os++;
        return {
            end: os
        };
    }
    // It's just a block then
    return Block(entry, buffer, os);
}

function Attr(entry, buffer, os) {
    os += entry.length;
    let names = NameList(buffer, os);
    let method = {};
    if (entry === 'attr_reader' || entry === 'attr_accessor') {
        method = names.reduce((t, n) => {
            t[n.slice(1)] = {
                posn: os
            };
            return t;
        }, method);
    }
    if (entry === 'attr_writer' || entry === 'attr_accessor') {
        method = names.reduce((t, n) => {
            t[n.slice(1) + '='] = {
                posn: os,
                arguments: [n.slice(1)]
            };
            return t;
        }, method);
    }
    return {
        method,
        end: names.end
    };
}

function HereDoc(entry, buffer, os) {
    os += entry.length;
    let ch = buffer[os];
    let word;
    let end;
    let indent;
    if (~_white.indexOf(ch)) return;
    if (~'-~'.indexOf(ch)) {
        indent = true;
        ch = buffer[++os];
    }
    if (~'"`\''.indexOf(ch)) end = Strings(ch, buffer, os++).end - 1;
    else {
        end = os + 1;
        while ((ch = buffer[end]) && !~'\r\n \t.)'.indexOf(ch)) end++;
    }
    word = buffer.slice(os, end);
    os = end + 1;
    while (os < buffer.length) {
        // find eol
        while ((ch = buffer[os]) && !~'\r\n'.indexOf(ch)) os++;
        // skip eol
        while ((ch = buffer[os]) && ~'\r\n'.indexOf(ch)) os++;
        if (indent) {
            while ((ch = buffer[os]) && ~' \t'.indexOf(ch)) os++;
        }
        if (buffer.slice(os, os + word.length) === word) {
            os += word.length;
            break;
        }
    }
    return {
        end: os
    };
}

HereDoc.isWordStart = true;

const internalEntries = {
        // only the entries in here will be used when
        // searching for the end of a method.
        'do': Block,
        'begin': Block,
        'for': Block,
        'case': Block,
        'if': ConditionAssignBlock, // assign and block control
        'unless': ConditionAssignBlock, // assigns and block control
        'while': ConditionBlock, // block control
        'until': ConditionBlock, // block control
        '"': Strings,
        '`': Strings,
        '\'': Strings,
        '#': Comment,
        '<<': HereDoc
    },
    externalEntries = {
        'module': Module,
        'class': Module,
        'def': Method,
        'include': Include,
        'alias': Alias,
        'attr_reader': Attr,
        'attr_writer': Attr,
        'attr_accessor': Attr,
        'alias_method': MethodAlias
    };

const internal = new Entries(internalEntries);
const external = new Entries(externalEntries);

function merge(target, insert) {
    let e;
    for (let k in insert) {
        e = insert[k];
        if (typeof e === 'number') target[k] = e;
        else if (typeof e === 'string') target[k] = e;
        else if (Array.isArray(e)) {
            if (k in target) target[k] = target[k].concat(e);
            else target[k] = e;
        } else if (k in target) merge(target[k], e);
        else if (e) target[k] = e;
    }
}

function parse(buffer, os) {
    let results = {};
    os = os || 0;
    if (os >= buffer.length) return;
    let processed;
    while (os < buffer.length) {
        os = skipWhite(buffer, os);
        if (buffer.slice(os, os + 3) === 'end' &&
            (os + 3 === buffer.length ||
                ~_defEnd.indexOf(buffer[os + 3]))) {
            results.end = os + 3;
            return results;
        }
        processed = internal.process(buffer, os) || external.process(buffer, os);
        if (processed) {
            os = processed.end;
            merge(results, processed);
        } else {
            //search for more whitespace
            os = skipNonWhite(buffer, os);
        }
    }
    results.end = os;
    return results;
}

module.exports = parse;