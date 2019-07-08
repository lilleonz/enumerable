module Enumerable
    def my_each
        i = 0
        while i < self.size
            yield(self[i], 1)
            i += 1
        end
    end

    def my_each_with_index
        i = 0
        while i < self.size
            yield(self[i], i)
            i += 1
        end
    end

    def my_select
        result = []
        self.my_each do |e|
            if yield e
                result << e
            end
        end
        result
    end

    def my_all?
        result = true
        self.my_each do |e|
            result = false unless yield e
        end
        result
    end

    def my_any?
        result = false
        self.my_each do |e|
            if yield e
                result = true
                break
            end
        end
        result
    end

    def my_none?
        result = true
        self.my_each do |e|
            if yield e
                result = false
                break
            end
        end
        result
    end

    def my_count num = nil
        count = 0
        if num
            self.my_each do |e|
                count += 1 if e == num
            end
        else
            self.my_each do |e|
                count += 1 if yield e
            end
        end
        count
    end

    def my_map proc = nil
        result = []
        if proc
            self.my_each_with_index do |e, i|
                result[i] = proc.call(e)
            end
        else
            self.my_each_with_index do |e, i|
                result[i] = yield e
            end
        end
        result
    end

    def my_inject *args
        case args.length
        when 1
            if args[0].class == Symbol
                memo = self[0]
                self.my_each_with_index do |e, i|
                    next if i == 0
                    memo = memo.method(args[0]).call(e)
                end
            else
                memo = args[0]
                self.my_each do |e|
                    memo = yield(memo, e)
                end
            end
        when 2
            memo = args[0]
            self.my_each do |e|
                memo = memo.method(args[1]).call(e)
            end
        else
            memo = self[0]
            self.my_each_with_index do |e, i|
                next if i  == 0
                memo = yield(memo, e)
            end
        end
        memo
    end
end

def multiply_els array
    array.my_inject(:*)
end


my_array = (1..4).to_a

# EACH
my_array.each{ |e| p e }
my_array.my_each{ |e| p e }

# EACH_WITH_INDEX
my_array.each_with_index{ |e, i| p "element: #{e}, index: #{i}" }
my_array.my_each_with_index{ |e, i| p "element: #{e}, index: #{i}" }

# SELECT
p my_array.select{ |item| item%2==0 }
p my_array.my_select{ |item| item%2==0 }

# ALL?
p my_array.all?{ |e| e > 1 }
p my_array.my_all?{ |e| e > 1 }

# ANY?
p my_array.any?{ |e| e < 1 }
p my_array.my_any?{ |e| e < 1 }

# NONE?
p my_array.none?{ |e| e > 1 }
p my_array.my_none?{ |e| e > 1 } 

# COUNT
p my_array.count { |e| e%2 == 1 }
p my_array.my_count { |e| e%2 == 1 }
p my_array.count 3
p my_array.my_count 3

# MAP
p my_array.map { |e| e ** 2 }
p my_array.my_map { |e| e ** 2 }
proc = Proc.new { |e| e ** 2 }
p my_array.my_map(proc)

# INJECT
p my_array.inject(:+)
p my_array.my_inject(:+)
p my_array.inject(1) { |product, n| product * n }
p my_array.my_inject(1) { |product, n| product * n }
p my_array.inject(1, :*)
p my_array.my_inject(1, :*)          
p my_array.inject{ |sum, n| sum + n }
p my_array.my_inject{ |sum, n| sum + n }
p multiply_els([2,4,5])