arr = ["david", "Alex", "bretta", "Charles"]
arr_order1 = arr.sort

# ["Alex", "Charles", "bretta", "david"]
puts "Ordered by default sort: #{arr_order1}"

# Customize
arr_order2 = arr.sort do |prev, post|
  puts "#{prev}: #{post}"
  prev.capitalize <=> post.capitalize
end

puts "Ordered by default sort: #{arr_order2}"


arr = [3, 6, 2, 1]
arr_order1 = arr.sort do |prev, post|
  tmp = prev <=> post
  tmp * -1
end

puts "* Descending Order: #{arr_order1}"