class Class1
    def initialize
      @name = "Class1"
    end
    
    def get_name
      @name
    end
  end
  
  # Class2 is defined to inherits Class1
  class Class2 < Class1
  end
  
  
  ins1 = Class1.new
  ins2 = Class2.new
  name1 = ins1.get_name   # Class1
  name2 = ins2.get_name   # Class2

  puts name1
  puts name2
  