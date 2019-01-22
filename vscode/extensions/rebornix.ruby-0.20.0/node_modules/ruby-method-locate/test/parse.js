'use strict';
let expect = require('chai').expect;
let parse = require('../lib/parse');

const util = require('util');
describe('parse', function() {
    context('simple parsing', function() {
        it('finds methods', function() {
            const contextString = `
def fn;end
def こんにちは
end
def other!
end`;
            const result = parse(contextString);

            expect(result.method).to.have.property('fn');
            expect(result.method).to.have.property('こんにちは');
            expect(result.method).to.have.property('other!');
            expect(result.method.fn).to.have.property('posn', 5);
            expect(result.method['こんにちは']).to.have.property('posn', 16);
            expect(result.method['other!']).to.have.property('posn', 30);
        });
        it('finds classes with methods', function() {
            const contextString = `
class Class;def test;end;end
class Other
  def test
  end
end`;
            const result = parse(contextString);

            expect(result.class).to.have.property('Class');
            expect(result.class).to.have.property('Other');
            expect(result.class.Class.method).to.have.property('test');
            expect(result.class.Other.method).to.have.property('test');
        });
    });

    context('with comments and strings', function() {
        it('finds methods', function() {
            const contextString = `
def fn #a comment here with a quote: " and an end
  "an escaped quote \\" with an end and a def here"
end# with a comment

def other!
  "an escaped quote \\" with an end"
end`;
            const result = parse(contextString);

            expect(result.method).to.have.property('fn');
            expect(result.method).to.have.property('other!');
        });
        it('finds classes', function() {
            const contextString = `
class Class;end # with end in a comment
class Other
  \`String with an end\`
  def test
  end# with a comment
end`;
            const result = parse(contextString);

            expect(result.class).to.have.property('Class');
            expect(result.class).to.have.property('Other');
            expect(result.class.Other.method).to.have.property('test');
        });
    });
    context('with blocks', function() {
        function check(contextString) {
            const result = parse(contextString);

            expect(result.method.fn).to.eql({
                posn: 5
            });
            expect(result.method).to.have.property('other!');
        }
        it("doesn't keep begin;end", function() {
            const contextString = `
def fn
  begin
  rescue => e
  end
end

def other!
end`;
            check(contextString);
        });
        it("get around modifiers", function() {
            const contextString = `
def fn
  a = 1 if true #gets ignored even the word end here
  b = 1 unless false
  begin
    puts 'test'
  end if true
end

def other!
end`;
            check(contextString);
        });
        it("works with a modifier and a block on the same line", function() {
            const contextString = `
def fn
  a = 1 if true; if true
    b = 1
  end
  begin
    puts 'test'
  end if true
end

def other!
end`;
            check(contextString);
        });
        it("recognises an assignment to a block result", function() {
            const contextString = `
def fn
  a = if true
    1
  end
  b = 5 ** if true
    2
  else
    1
  end
end

def other!
end`;
            check(contextString);
        });
        it("recognises a block following a semi colon", function() {
            const contextString = `
def fn
  a = 1; if true
    1
  end
  b = 5; if true
    2
  else
    1
  end
end

def other!
end`;
            check(contextString);
        });
        it("recognises a while", function() {
            const contextString = `
def fn
  a = 1 while false
  while true
    b = 1
    break
  end
end

def other!
end`;
            check(contextString);
        });
        it("recognises an until", function() {
            const contextString = `
def fn
  begin
    a = 1
  end until false
  until true
    b = 1
    break
  end
end

def other!
end`;
            check(contextString);
        });
        it("recognises a for", function() {
            const contextString = `
def fn
  for a in [1,2]
    puts a
  end
end

def other!
end`;
            check(contextString);
        });
        it("recognises a do", function() {
            const contextString = `
def fn
  (1..3).each do |a|
    puts a
  end
end

def other!
end`;
            check(contextString);
        });
        it("recognises a case", function() {
            const contextString = `
def fn(x)
  case x
  when 5
    puts x
  else
    puts "none"
  end
end

def other!
end`;
            check(contextString);
        });
    });
    context('with nested modules and classes', function() {
        it('finds all depth elements', function() {
            const contextString = `
module Module
  class Class
    def initialize
    end
  end
  def other!
  end
end
`;
            const result = parse(contextString);
            expect(result.module).to.have.property('Module');
            expect(result.module.Module.class).to.have.property('Class');
            expect(result.module.Module.class.Class.method).to.have.property('initialize');
            expect(result.module.Module.method).to.have.property('other!');
        });
    });

    context('with class methods', function() {
        it('finds them', function() {
            const contextString = `
module Module
  class Class
    def initialize
    end

    def self.mine
    end
  end
  def other!
  end
end
`;
            const result = parse(contextString);
            expect(result.module).to.have.property('Module');
            expect(result.module.Module.class).to.have.property('Class');
            expect(result.module.Module.class.Class.method).to.have.property('initialize');
            expect(result.module.Module.class.Class.classMethod).to.have.property('mine');
            expect(result.module.Module.method).to.have.property('other!');
        });
    });
    context('when defining methods on the class', function() {
        it('finds them', function() {
            const contextString = `
module Module
  class Class
    def initialize
    end

    class << self
      def mine
      end
    end
  end
  def other!
  end
end
`;
            const result = parse(contextString);
            expect(result.module).to.have.property('Module');
            expect(result.module.Module.class).to.have.property('Class');
            expect(result.module.Module.class.Class.method).to.have.property('initialize');
            expect(result.module.Module.class.Class.classMethod).to.have.property('mine');
            expect(result.module.Module.method).to.have.property('other!');
        });
    });
    context("when defining modules and classes with '::'", function() {
        it('finds them', function() {
            const contextString = `
module Module::First
  module Second
    def two
    end
  end
  class Second::Class
    def initialize
    end
  end
  def other!
  end
end
`;
            const result = parse(contextString);
            expect(result.module).to.have.property('Module');
            expect(result.module.Module.module).to.have.property('First');
            expect(result.module.Module.module.First.module).to.have.property('Second');
            expect(result.module.Module.module.First.module.Second.method).to.have.property('two');
            expect(result.module.Module.module.First.module.Second.class).to.have.property('Class');
            expect(result.module.Module.module.First.module.Second.class.Class.method).to.have.property('initialize');
            expect(result.module.Module.module.First.method).to.have.property('other!');
        });
    });
    context("inheriting", function() {
        it('includes', function() {
            const contextString = `
class Class
  include Other, OtherTwo
end
`;
            const result = parse(contextString);
            expect(result.class).to.have.property('Class');
            expect(result.class.Class.include).to.include('Other');
            expect(result.class.Class.include).to.include('OtherTwo');
        });
        it('inherits', function() {
            const contextString = `
class Class < Other
end
`;
            const result = parse(contextString);
            expect(result.class).to.have.property('Class');
            expect(result.class.Class.inherit).to.eql('Other');
        });
    });
    context('aliasing', function() {
        it('uses an alias_method', function() {
            const contextString = `
class Class
  alias_method :m2 :m1
  alias_method :m3, :m1
end
`;
            const result = parse(contextString);
            expect(result.class.Class.method).to.have.property('m2');
            expect(result.class.Class.method).to.have.property('m3');
        });
        it('uses an alias to a (potential) method', function() {
            const contextString = `
class Class
  alias m2 m1
  alias :m3 :m1
end
`;
            const result = parse(contextString);
            expect(result.class.Class.method).to.have.property('m2');
            expect(result.class.Class.method).to.have.property('m3');
        });
        it("doesn't use an alias to a local or global", function() {
            const contextString = `
class Class
  alias @m1 @m2
  alias $m3 $m4
end
`;
            const result = parse(contextString);
            expect(result.class.Class.method).to.be.an('undefined');
        });
    });
    context("HEREDOC", function() {
        it("skips through a HEREDOC", function() {
            const contextString = `
def fn

  <<HEREDOC
    end

    def other
HEREDOC
end

def fn2
end
`;
            const result = parse(contextString);
            expect(result.method).to.have.property('fn');
            expect(result.method).to.have.property('fn2');
            expect(result.method).not.to.have.property('other');
        });
        it("skips through a ~HEREDOC", function() {
            const contextString = `
def fn

  <<~HEREDOC
    end
    def other
  HEREDOC
end

def fn2
end
`;
            const result = parse(contextString);
            expect(result.method).to.have.property('fn');
            expect(result.method).to.have.property('fn2');
            expect(result.method).not.to.have.property('other');
        });
        it("skips through a -'HEREDOC'", function() {
            const contextString = `
def fn

  <<-'delimiter'
    end
    def other
  delimiter
end

def fn2
end
`;
            const result = parse(contextString);
            expect(result.method).to.have.property('fn');
            expect(result.method).to.have.property('fn2');
            expect(result.method).not.to.have.property('other');
        });
        it("skips through a HEREDOC with a method call", function() {
            const contextString = `
def fn

  a = <<delimiter.test
    end
    def other
delimiter
end

def fn2
end
`;
            const result = parse(contextString);
            expect(result.method).to.have.property('fn');
            expect(result.method).to.have.property('fn2');
            expect(result.method).not.to.have.property('other');
        });
        it("skips through a HEREDOC as an argument", function() {
            const contextString = `
def fn

  call(<<argument)
    end
    def other
argument
end

def fn2
end
`;
            const result = parse(contextString);
            expect(result.method).to.have.property('fn');
            expect(result.method).to.have.property('fn2');
            expect(result.method).not.to.have.property('other');
        });
    });
});