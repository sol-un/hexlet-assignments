# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def test_push!
    stack = Stack.new
    stack.push! 'test'
    assert_equal stack.size, 1
    assert_equal stack.to_a, %w[test]
  end

  def test_pop!
    stack = Stack.new %w[test1 test2]

    top_element = stack.pop!
    assert_equal stack.size, 1
    assert_equal top_element, 'test2'

    stack.pop!
    nil_element = stack.pop!
    assert nil_element.nil?
  end

  def test_clear!
    stack = Stack.new %w[test1 test2]

    stack.clear!
    assert_equal stack.size, 0
  end

  def test_empty?
    stack = Stack.new %w[test]
    refute stack.empty?

    stack.pop!
    assert stack.empty?
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?