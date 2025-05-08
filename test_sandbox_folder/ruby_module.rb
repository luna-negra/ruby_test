module Circle
    include Math

    def area(r)
        puts r ** 2 * PI
    end

    def Circle.area(r)
        puts r ** 2 * PI
    end
end

c = Circle
puts c.area(5)


class Test
    extend Circle

    def Test.circumstance(r)
        r * 2 * Circle::PI
    end
end

puts Test.area(20)
puts Test.circumstance(20)


class InheritTest < Test
    def initialize
    end
end


it = InheritTest.new
puts "===="
puts InheritTest.area(10)

