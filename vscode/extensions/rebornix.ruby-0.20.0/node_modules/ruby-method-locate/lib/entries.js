'use strict';


const _nb_white = '\t ';
const _eol = '\r\n;';
const _white = _nb_white + _eol;

const _word_end = '(#<';
const _defEnd = _white + _word_end;

class Entries {
    constructor(elements) {
        this.entry = [];
        this.first = '';
        for (let key in elements) {
            this.add(key, elements[key]);
        }
    }
    add(initialiser, processor) {
        let pos = this.first.indexOf(initialiser[0]);
        if (!~pos) {
            this.first += initialiser[0];
            this.entry.push([{ initialiser, processor }]);
        } else {
            this.entry[pos].push({ initialiser, processor });
        }
    }
    process(buffer, os) {
        let pos = this.first.indexOf(buffer[os]);
        if (!~pos) return;
        let processed;
        let endPos;
        if (this.entry[pos].some(entry => {
                endPos = os + entry.initialiser.length;
                if (entry.initialiser.length === 1 ||
                    (entry.initialiser == buffer.slice(os, endPos) &&
                        //must be a word edge - although some of the end options
                        //wouldn't end the word for some key words, they would
                        //be an error, and that's enough for us to do something with
                        //it here
                        (endPos === buffer.length || ~_defEnd.indexOf(buffer[endPos]) || entry.processor.isWordStart)
                    )) {
                    processed = entry.processor(entry.initialiser, buffer, os);
                    // console.log("Found: ", os, `"${entry.initialiser}"`, buffer.slice(os,processed.end));
                    return !!processed;
                }
            }));
        return processed;
    }
}

module.exports = Entries;