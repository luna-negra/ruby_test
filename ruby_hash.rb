# hash test
# set the number of product with color as key

# default values for all key is set by 0
h = Hash.new(0)

# h is printed out with {}
# however h[key] is printed out as 0
puts h
puts h["red"]

# set the value manually
h["red"] = 4
h["green"] = 10
h["blue"] = 7
h["orange"] = 11

# edited h
# {"red"=>4, "green"=>10, "blue"=>7, "orange"=>11}
puts h  

# sort_by: use key and value as a param of sort_by
color = h.sort_by do |k, v|
  v
end

# Sorted Result: [["red", 4], ["blue", 7], ["green", 10], ["orange", 11]]
puts "Sorted Result: #{color}"

# if sort_by was set by k,
color = h.sort_by do |k, v| 
    k 
end

# Sorted Result by Key: [["blue", 7], ["green", 10], ["orange", 11], ["red", 4]]
puts "Sorted Result by Key: #{color}"

# descending order will beimplemented by Array.reverse
test = color.reverse
puts test.is_a? Array