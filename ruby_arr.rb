arr = []

# push new atom
# push method gets a param as *args
arr.push(10, 11, 12)

# [10, 11, 12]
puts "#{arr}"

# append and <<(shovel)
# same as push but they can add only one element.

# error: arr << 10, 11
# error: arr.append(10, 11)
arr << 13
puts "#{arr}"

arr.append(14)
puts "#{arr}"

# insert: add new atom at the specific index
# can insert multiple atoms
arr.insert(0, 1, 2, 3)
puts "#{arr}"

puts "----- DELETE-----"

# pop: remove at the end of array
arr = [1, 2, 3, 4, 10, 11, 12, 13]
tmp = arr.pop
puts "#{tmp}"
puts "#{arr}"
# arr = [1, 2, 3, 4, 10, 11, 12]

# it is possible to remove specific number of atom from the end.
new_arr = arr.pop(3)
puts "#{new_arr}"
puts "#{arr}"
# new_arr = [10, 11, 12]
# arr = [1, 2, 3, 4]

# delete_at: use index to remove specific value and return it.
# delete_ method does not return removed atom.
tmp = arr.delete(0)
puts "#{tmp}"
puts "#{arr}"
# tmp = 1
# arr = [2, 3, 4]

# delete_if: using array each, remove the atom that not fulfill the condition.
# return the remained data and change original arr atoms.
arr = Array(1...10)
tmp = arr.delete_if do |v|
  v % 2 == 0
end

puts "#{tmp}"
puts "#{arr}"
# arr = [1, 3, 5, 7, 9]
# tmp = [1, 3, 5, 7, 9]

# delete: remove specific value in array
# can remove only one value at once.
arr.delete(5)
puts "#{arr}"
# arr = [1, 3, 7, 9]

puts ("========")

arr = [1, 2, 3, 4]
tmp = arr.collect do |n|
  n * 2
end

puts "#{arr}"
puts "#{tmp}"

tmp2 = tmp.map do |n|
  n * 2
end

puts "#{tmp2}"

# select
tmp3 = arr.select do |n| 
  n % 2 == 0
end

puts "#{tmp3}"   # [2, 4]

puts ("========")
# Convert 2D array in Hash
array = [["name", "Alex"], ["age", 30], ["nation", "USA"]]
hash = Hash[array]
puts hash

# with zip
hash = Hash[["name", "age", "nation"].zip(Array(1..3))]
puts hash