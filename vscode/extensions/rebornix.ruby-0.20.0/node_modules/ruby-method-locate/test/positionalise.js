'use strict';
let expect = require('chai').expect;
let positionalise = require('../lib/positionalise');


describe('positionalise', function() {
    let refString;
    beforeEach(function() {
        refString = "012345678\r01234567\r\n012345678\n012345";
    });
    context('single depth', function() {
        it('replaces numeric properties', function() {
            const result = positionalise(refString, {
                first: 2,
                second: 12,
                third: 22,
                fourth: 32
            });
            expect(result.first).to.have.property('line', 0);
            expect(result.first).to.have.property('char', 2);
            expect(result.second).to.have.property('line', 1);
            expect(result.second).to.have.property('char', 2);
            expect(result.third).to.have.property('line', 2);
            expect(result.third).to.have.property('char', 2);
            expect(result.fourth).to.have.property('line', 3);
            expect(result.fourth).to.have.property('char', 2);
        });
    });
    context('with depth', function() {
        it('replaces numeric properties', function() {
            const result = positionalise(refString, {
                pos: 2,
                second: {
                    pos: 12,
                    third: {
                        pos: 22,
                        fourth: { pos: 32 }
                    }
                }
            });
            expect(result.pos).to.have.property('line', 0);
            expect(result.pos).to.have.property('char', 2);
            expect(result.second.pos).to.have.property('line', 1);
            expect(result.second.pos).to.have.property('char', 2);
            expect(result.second.third.pos).to.have.property('line', 2);
            expect(result.second.third.pos).to.have.property('char', 2);
            expect(result.second.third.fourth.pos).to.have.property('line', 3);
            expect(result.second.third.fourth.pos).to.have.property('char', 2);
        });
    });
    context('with multi-line breaks', function() {
        it('replaces numeric properties', function() {
            refString = '\n\n\r0\r\n\n\r0';
            const result = positionalise(refString, {
                first: 0,
                second: 2,
                third: 3,
                fourth: 8
            });
            expect(result.first).to.have.property('line', 0);
            expect(result.first).to.have.property('char', 0);
            expect(result.second).to.have.property('line', 2);
            expect(result.second).to.have.property('char', 0);
            expect(result.third).to.have.property('line', 3);
            expect(result.third).to.have.property('char', 0);
            expect(result.fourth).to.have.property('line', 6);
            expect(result.fourth).to.have.property('char', 0);
        });
    });
    context('numbers as strings', function() {
        it("doesn't try to convert the number", function() {
            const result = positionalise(refString, {
                first: 0,
                second: '2'
            });
            expect(result.first).to.have.property('line');
            expect(result.second).to.be.a('string');
        });
    });
});