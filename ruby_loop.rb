=begin
* print out even number's product table by using loop and condition flow
* this is a drill code
=end

a = Array(1...10)

# config
n_even_print = true
n_odd_print = false
m_even_print = false
m_odd_print = false

for n in a
    next if (!n_even_print && (n % 2 == 0)) || (!n_odd_print && (n % 2 == 1))
    puts "#{n} Dan"

    for m in a
        next if (!m_even_print && (m % 2 == 0)) || (!m_odd_print && (m % 2 == 1))
        puts "* #{n} * #{m} = #{n * m}"
    end
end

