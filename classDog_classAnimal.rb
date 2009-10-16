#!

#---requirements

require "random_data"

require "test/unit"

#---classes

class Animal

  def eat
    puts "#{name} says slurp!"
  end
 
  def poop 
    puts "#{name} made a doody!"
  end
  
  def sleep
    puts "#{name} is sleeping - Zzz!"
  end 
  
end #end class Animal

class Dog < Animal

  def name
    @name
  end
  
  def name=(newname) 		
    @name=newname
  end
  
  def set_color(color)
  fur = ['black', 'brown', 'white', 'other'].to_a
    raise TypeError,
      "#{color} is not a string!" unless color.is_a?(String)
      if (fur.to_s !~/#{color.to_s}/)
      raise ArgumentError,
      "You must specify a color!"
      end
      self.shedsfur=(color)
  end
  
  def shedsfur=(color)
  end
  
  def bark
  puts "#{name} says bark bark!"
  end   
  
  def sit
    puts "#{name} sit!"
  end
  
  def fetch
    puts "#{name}, go get it boy!"
  end
  
  def play
  ball = Random.number(9)
  toy = ["squeaky rubber chicken", "sqeaky rubber lobster", "squeaky rubber hamburger"]
    if ball < 5
      puts "*Throws ball!*"
      puts fetch
      puts bark
    else
    puts "#{name} is playing with #{toy.rand}"
    end
  end #play

end  #end class Dog

class Cat < Animal

  def name
    @name
  end
  
  def name=(newname)
    @name=newname
  end
  
  def set_color(pattern)
  fur = ['solid black', 'orange stripe', 'patches', 'tan', 'marble', 'other'].to_a
    raise TypeError,
      "#{pattern} is not a string!" unless pattern.is_a?(String)
      if (fur.to_s !~/#{pattern.to_s}/)
      raise ArgumentError,
      "You must specify a pattern!"
      end
    self.shedsfur=(pattern)
  end
  
  def shedsfur=(patter)
  end
  
  def meow
    puts "#{name} says meow!"
  end
  
  def purr
    puts "#{name} is purring!"
  end
  
  def pounce
  toy = ["toy mousey", "toy fishy", "toy birdy"]  
    puts "#{name} is pouncing on #{toy.rand}"
  end

end #end class Cat

class Fish < Animal

  def name
    @name
  end
  
  def name=(newname)
    @name=newname
  end
  
  def set_color(color)
  scales = ['black', 'white', 'rainbow', 'red', 'blue', 'other'].to_a
    raise TypeError,
      "#{color} is not a string!" unless color.is_a?(String)
      if (scales.to_s !~/#{color.to_s}/)
      raise ArgumentError,
      "You must specify a color!"
      end
    self.shedsskin=(color)
  end
  
  def shedsskin=(color)
  end
  
  def swim
    puts "#{name} is swimming!"
  end
  
  def play
  bubble = Random.number(9)
    if bubble < 5  
      puts "#{name} made #{bubble} bubbles!"
    else
      swim
  end
 
end #end class Fish

#---variables

#---test cases

class TestPets < Test::Unit::TestCase

  def setup #do this before every test case
    animal = ["Dog", "Cat", "Fish"]
  end

  def teardown #do this after every test case
    puts "tah-dah!"
  end

  def test_01 
    description = "Does #{animal} do everything an animal does?" 
      pet = animal.rand
      pet.new
        assert(pet.eat)
        assert(pet.sleep)
        assert(pet.poop)
    puts description 
  end

  def test_02
    description = "Exercise Dog class"
    newname = Random.firstname
      doggy = Dog.new
      doggy.name=("#{newname}")
       assert(doggy.bark)
       assert(doggy.sit)
       assert(doggy.play)
    puts description  
  end

  def test_03
    description = "Exercise Cat class"
    newname = Random.firstname
      kitty = Cat.new
      kitty.name=("#{newname}")
        assert(kitty.meow)
          assert(kitty.meow.is_a?(String))
	assert(kitty.purr)
          assert(kitty.purr.is_a?(String))
	assert(kitty.pounce)
          assert(kitty.pounce.is_a?(String))
    puts description
  end

  def test_04
    description = "Exercise Fish class"
    newname = Random.firstname
      fishy = Fish.new
      fishy.name=("#{newname}")
        assert(fishy.swim)
        assert(fishy.play)
    puts description
  end
  
  def test_05
    description = "Exercise error handling"
    color = ['black', 'brown', 'white', 'rainbow', 'red', 'blue', 'solid black', 'orange stripe', 'patches', 'tan', 'marble', 'other'].to_a
      begin
        fishy = Fish.new
	assert(fishy.set_color(color.rand))
	kitty = Cat.new
	assert(fishy.set_color(color.rand))
	doggy = Dog.new
	assert(doggy.set_color(color.rand))
      rescue => r
      puts "Oops! No such #{color} color!\n#{r.backtrace}"
      end
  end
end
end

