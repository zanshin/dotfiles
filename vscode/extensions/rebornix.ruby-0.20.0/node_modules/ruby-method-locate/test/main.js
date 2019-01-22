'use strict';
const fs = require('fs');
const path = require('path');

let expect = require('chai').expect;
let parse = require('../main');

describe('parse - main', function() {
    context('file parsing', function() {
        it('finds methods', function() {
            const filename = path.join(__dirname, 'sample', 'basic.rb');
            return parse(filename).then(result => {
                expect(result).to.eql({
                    module: {
                        Module: {
                            class: {
                                Class: {
                                    method: {
                                        call: {
                                            posn: {
                                                char: 8,
                                                line: 5
                                            }
                                        },
                                        initialize: {
                                            posn: {
                                                char: 8,
                                                line: 2
                                            }
                                        }
                                    },
                                    posn: {
                                        char: 8,
                                        line: 1
                                    }
                                }
                            },
                            posn: {
                                char: 7,
                                line: 0
                            }
                        }
                    }
                });
            });
        });

        it('fails for a non existant file', function() {
            const filename = path.join(__dirname, 'sample', 'this is not a file');
            return parse(filename)
                .then(result => {
                    throw result;
                }, err => expect(err).to.exist);
        });
    });
});