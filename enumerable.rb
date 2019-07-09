module Enumerable
  def my_each
    for i in 0...self.length
      yield(self[i])
  end

  def my_each_with_index
    for i in 0...self.length
      yield(self[i], i)
  end

  def my_select
    newCollection = []
    self.my_each { |item| newCollection.push(item) if yield(item) } 
    return newCollection
  end

  def my_all?
    output = true
    self.my_each { |item| output = false unless yield(item) }
  end

  def my_any?
    output = false
    self.my_each { |item| output = true if yield(item) }
    return output
  end

  def my_none?
    output = true
    self.my_each { |item| output = false if yield(item) }
    return output
  end

  def my_count(num = nil)
    count = 0
    if item != nil
      self.my_each { |element| count += 1 if element == item }
    elsif block_given?
      self.my_each { |element| count += 1 if yield(element) }
    else
      count = self.length
    end
    return count    
  end

  def my_map(proc = nil)
    if block == nil
      self.my_each_with_index { |element, index| self[index] = yield(element) }
    elsif block != nil && block_given?
      self.my_each_with_index { |element, index| self[index] = block.call(element) }
    else block
      self.my_each_with_index { |element, index| self[index] = block.call(element) }    
    end
  return self
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
    return accumulator
  end
end

def multiply_els(array)
  return array.my_inject(1) { |acc, e| acc * e }
end