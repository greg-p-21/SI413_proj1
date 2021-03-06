# 99 Bottles of beer, in Ruby
# By Victor Borja, Sep 14, 2006
# This one shows my favorite Ruby features:
#   continuations, open classes, singleton classes, blocks and being funny!

class Integer # The bottles
  def drink; self - 1; end
end

class << song = nil
  attr_accessor :wall

  def bottles
    (@bottles.zero? ? "no more" : @bottles).to_s <<
      " bottle" << ("s" unless @bottles == 1).to_s
  end
  
  def of(bottles)
    @bottles = bottles
    (class << self; self; end).module_eval do
      define_method(:buy) { bottles }
    end
    self
  end
  
  def sing(&step)
    puts "#{bottles.capitalize} of beer on the wall, #{bottles} of beer."
    if @bottles.zero?
      print "Go to the store buy some more, "
      step = method :buy
    else
      print "Take one down and pass it around, "
    end
    @bottles = step[@bottles]
    puts "#{bottles} of beer on the wall."
    puts "" or wall.call unless step.kind_of? Method
  end

end

callcc { |song.wall| song.of(99) }.sing { |beer| beer.drink }
