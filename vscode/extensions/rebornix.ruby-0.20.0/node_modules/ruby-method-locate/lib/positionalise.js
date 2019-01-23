'use strict';

function lines(buffer) {
    let ch, l = [],
        os = 0;
    while ((ch = buffer[os])) {
        if (ch === '\r' && buffer[os + 1] !== '\n') l.push(os);
        else if (ch === '\n') l.push(os);
        os++;
    }
    return l;
}

function pos(structure, lines) {
    for (let a in structure) {
        if (Array.isArray(structure[a])) continue;
        if (typeof structure[a] === 'string') continue;
        if (typeof structure[a] === 'number') {
            let os = structure[a],
                c = 0;
            while (c < lines.length && os > lines[c]) c++;
            if (c === 0) structure[a] = {
                line: 0,
                char: os
            };
            else structure[a] = {
                line: c,
                char: os - lines[c - 1] - 1
            };
        } else pos(structure[a], lines);
    }
    return structure;
}

module.exports = function(buffer, structure) {
    return pos(structure, lines(buffer));
};