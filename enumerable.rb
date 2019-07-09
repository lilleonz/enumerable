module Enumerable
  def my_each
    for i in 0...self.length
      yield(self[i])
    end
  end

  def my_each_with_index
    for i in 0...self.length
      yield(self[i], i)
    end
  end

  def my_select
    newCollection = []
    self.my_each { |item| newCollection.push(item) if yield(item) } 
    newCollection
  end

  def my_all?
    output = true
    self.my_each { |item| output = false unless yield(item) }
    output
  end

  def my_any?
    output = false
    self.my_each { |item| output = true if yield(item) }
    output
  end

  def my_none?
    output = true
    self.my_each { |item| output = false if yield(item) }
    output
  end

  def my_count(item = nil)
    count = 0
    if item != nil
      self.my_each { |element| count += 1 if element == item }
    elsif block_given?
      self.my_each { |element| count += 1 if yield(element) }
    else
      count = self.length
    end
    count
  end

  def my_map(block = nil)
    if block == nil
      self.my_each_with_index { |element, index| self[index] = yield(element) }
    elsif block != nil && block_given?
      self.my_each_with_index { |element, index| self[index] = block.call(element) }
    elsif block
      self.my_each_with_index { |element, index| self[index] = block.call(element) }    
    end
  self
  end

  def my_inject(intial = nil)
    if intial == nil
      accumulator = self.first
    else
      accumulator = intial
    end
    self.my_each do |element|
      accumulator =yield(accumulator, element)
    end
    accumulator
  end
end

def multiply_els(array)
  array.my_inject(1) { |acc, e| acc * e }
end

var1 = multiply_els([2,4,5])
print var1
puts ""

block = Proc.new{|string| string.upcase}
var2 = ["a", "b", "c"].my_map(block)
print var2