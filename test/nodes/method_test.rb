require File.dirname(__FILE__) + '/../test_helper'

class MethodTest < Test::Unit::TestCase
  include TestHelper

  define_method :"test a method" do
    src = "def foo(a, b = nil, c = :foo, *d, &block)\n        bar\n        baz\n      end"
    method = build(src).first
    assert_equal src, method.to_ruby
    assert_equal src, method.src
  end

  define_method :"test a class method" do
    src = "def self.foo(a, b = nil, c = :foo, *d, &block)\n        bar\n        baz\n      end"
    method = build(src).first
    assert_equal src, method.to_ruby
    assert_equal src, method.src
  end
  
  define_method :"test method definition: def t(a = []); end" do
    src = "def t(a = []) end"
    method = build(src).statements.first
    assert_equal src, method.to_ruby
  end
  
  define_method :"test: method definition: def t(*) end (a single star)" do
    src = "def t(*) end"
    call = build(src).statements.first
    assert_equal src, call.to_ruby
  end
  
  define_method :"test method definition: def <<()" do
    src = "def <<(arg) end"
    method = build(src).statements.first
    assert_equal src, method.to_ruby
  end
  
  define_method :"test method body w/ statements separated by semicolon" do
    src = "def <<(arg) foo; bar; end"
    method = build(src).statements.first
    assert_equal src, method.to_ruby
  end
  
  define_method :"test method body rescue and ensure block" do
    src = "def a(b, c)\n  d\nrescue A\n e\nensure\nb\nend"
    method = build(src).statements.first
    assert_equal src, method.to_ruby
  end
end