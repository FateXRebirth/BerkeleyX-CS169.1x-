# When done, submit this entire file to the autograder.

# Part 1

def sum(arr)
  # YOUR CODE HERE
  sum = 0
  if arr.empty?
    return 0
  end
  arr.each do |i|
    sum += i
  end
  return sum
end

def max_2_sum(arr)
  # YOUR CODE HERE
  if arr.empty?
    return 0
  end
  if arr.length == 1
    return arr[0]
  end
  newArr = arr.sort { |x,y| y <=> x }
  return newArr[0] + newArr[1]
end

def sum_to_n?(arr, n)
  # YOUR CODE HERE
  if arr.length < 2
    return false
  end
  for i in 0..arr.length-1 do 
    for j in i+1..arr.length-1 do
      if arr[i]+arr[j] == n
        return true
      end
    end
  end
  return false
end

# Part 2

def hello(name)
  # YOUR CODE HERE
  return "Hello, ".concat(name)
end

def starts_with_consonant?(s)
  # YOUR CODE HERE
  if s.length == 0
    return false
  end
  if s =~ /\A[aeiouAEIOU0-9!@#$%^&*()_]/
    return false
  else
    return true
  end
end

def binary_multiple_of_4?(s)
  # YOUR CODE HERE
  if s.length == 0
    return false
  end
  
  if s =~ /[a-zA-Z]/
    return false
  else
    number = s.to_i(2)
  end
  
  if number%4 == 0
    return true
  else
    return false
  end
end

# Part 3

class BookInStock
# YOUR CODE HERE
  def initialize(isbn, price)
    if isbn == '' || price <= 0
      raise ArgumentError, "ISBN can't be empty or Price can't less or equal to zero"
    end
    @isbn = isbn
    @price = price
  end
  
  attr_accessor :isbn
  attr_accessor :price
  
  def price_as_string
    return "$%.2f" % [price]
  end
end
