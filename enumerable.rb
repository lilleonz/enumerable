# This is a project for Microverse
# By Leon Little
# frozen_string_literal: true

module Enumerable
  def my_each
    for i in 0...self.length
      yield(self[i])
    end
  end

  def my_each_with_index
    for i in 0...self.length
      yield(self[i],i)
    end
  end

  def my_select
    new_collection = []
    my_each { |item| new_collection << item if yield(item) }
    new_collection
  end

  def my_all?
    output = true
    my_each { |item| output = false unless yield item }
    output
  end

  def my_any?
    output = false
    my_each { |item| output = true if yield(item) }
    output
  end

  def my_none?
    output = true
    my_each { |item| output = false if yield(item) }
    output
  end

  def my_count(item = nil)
    count = 0
    if !item.nil?
      my_each { |element| count += 1 if element == item }
    elsif block_given?
      my_each { |element| count += 1 if yield(element) }
    else
      count = length
    end
    count
  end

  def my_map(block = nil)
    if block == nil?
      my_each_with_index{ |element,index| self[index] = yield(element) }
    elsif !block.nil? && block_given?
      my_each_with_index{ |element,index| self[index] = block.call(element) }
    elsif block
      my_each_with_index{ |element,index| self[index] = block.call(element) }
    end
    self
  end

  def my_inject(initial = nil)
    accumulator =
      if initial.nil?
        first
      else
        initial
      end
    my_each do |element|
      yield(accumulator, element)
    end
    accumulator
  end
end

def multiply_els(number_list)
  number_list.my_inject(1) { |x, y| x * y }
end

# Test cases
test_array = Array.new(10) { rand(0..100) }

# Each
test_array.my_each { |value| puts "#{value} " }

# Each with Index
test_array.my_each_with_index { |value, index| puts "Index: #{index} - Value: #{value}" }

# Select
puts test_array.my_select { |value| (value % 2) == 0 }

# All
puts test_array.my_all? { |value| value > 30 }

# Any
puts test_array.my_any? { |value| value == 0 }

# None
puts test_array.my_none? { |value| value < 10 }

# Count
puts test_array.my_count { |value| (value % 2) != 0 }

# Map
puts test_array.my_map { |value| value > 50 }

# Inject
puts multiply_els([2,4,5])