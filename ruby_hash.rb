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


# old format
h = {
    "age" => 10,
    "name" => "alex",
    "nation" => "USA"
}
puts h

# recent format for symbol
h = {
    "age": 10,
    "name": "Alex",
    "nation": "USA"
}
puts h

# with symbol
h = {
    :age => 10,
    :name => "alex", 
    :nation => "USA",
}

puts h

# another format with symbol
h = {
    age: 10,
    name: "Alex",
    nation: "USA"
}
puts h

puts h[:age]
puts h[:name]
puts h["age"]   # does not print out because key 'age' is not a string.



# select: acts like array each but only return the key in Hash
h.select do |k|
    puts "#{k}: #{h[k]}"
end

h.each do |k, v|
    puts k
end



# Examples Hash with Case-When Syntax

movies = {
  StarWars: 4.8, 
  Divergent: 4.7
  }

puts "What would you like to do? "
choice = gets.chomp

case choice
  when "add"
    print "* Movie' Title: "
    title = gets.chomp.to_sym
    print "* Rating (1~5): "
    rating = gets.chomp.to_i

    # same as: if movies[title.to_sym].nil?
    if movies[title.to_sym].is_a? NilClass                 
      movies[title] = rating
      puts "Successfully Add title '#{title}' with rating #{rating}"      

    else
      puts "[Warning] You have already registered"

    end

  when "update"
    puts "Updated!"
  when "display"
    puts "Movies!"
  when "delete"
    puts "Deleted!"
  else
    puts "Error!"
end