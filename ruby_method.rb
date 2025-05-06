# ruby function(method)

# default form
def function_name 
    puts "Hello Ruby"
end

# print out string.
function_name

# with parameter
def sum_10(num)
    return num.to_i + 10
end

# 20 wth param 10
puts sum_10(10)


# with undefined param as a Array
def print_undefined(*args)
    puts "* Your Input: #{args}"
    return nil
end

# calling print_undefined ("test", "ruby", "code")
print_undefined("test", "ruby", "code")

# It is possible to use print_undefined without params
print_undefined()
puts "-----"

# with undefined param as a Hash
def print_undefined2(**kwargs)
    puts "* Your Input: #{kwargs}"
    return nil
end

# calling print_undefined
print_undefined2(name: "Alex", age: 20, nation: "UK")

# nameless function: similar to python lambda
a = 1
5.times { 
  a *= 2
  puts a
}

# return value
def last_line(num)
    num ** 2
end

puts "----"
puts last_line(10)