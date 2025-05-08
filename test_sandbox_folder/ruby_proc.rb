# without proc
arr = [1.2, 3.45, 0.91, 7.727, 11.42, 482.911]
tmp = arr.collect { |f| f.floor }
puts "#{tmp}"
# [1, 3, 0, 7, 11, 482]

# with Proc
floor_proc = Proc.new { |f| f.floor }
tmp = arr.collect(&floor_proc)
puts "#{tmp}"

# example with method
def greetings(name)
    yield(name)
end

greet = Proc.new { |name| puts "Hello, #{name}" }
greetings(name="pavel", &greet)

# .call
greet.call("Alex")


# use symbol as a proc
arr = Array(1..10)
tmp = arr.map(&:to_f)
puts "#{tmp}"
# [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]



# lambda function: type of Proc
lamb_func = lambda do |arr|
    arr.collect { |n| n * 2}
  end
  
  arr = [1, 2, 3, 4]
  def multiple_2(array, lamb)
     lamb.call(array)
  end
  
  puts "#{multiple_2(arr, lamb_func)}"


# Proc and Lambda
def batman_ironman_proc
    victor = Proc.new { return "Batman will win!" }
    victor.call  # return "Batman will win!"

    ## ignored by Proc return.
    puts "Test"
    "Iron Man will win!"
  end
  
  puts batman_ironman_proc
  puts ""
  
  def batman_ironman_lambda
    victor = lambda { return "Batman will win!" }
    victor.call  # just have only string "Batman will win"
    "Iron Man will win!"
  end
  
  puts batman_ironman_lambda
