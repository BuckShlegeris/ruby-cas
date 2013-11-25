require "magic"

class Expression
  def normalize
    self
  end



end




class Variable < Expression
  magic_metaprogram :name

  def inspect
    name
  end
end

class Constant < Expression
  magic_metaprogram :value

  def inspect
    value
  end
end

class Sum < Expression
  magic_metaprogram :terms

  def inspect
    terms.map(&:inspect).join("+")
  end
end

class Product < Expression
  magic_metaprogram :coefficient, :terms

  def inspect
    return terms.map {|x| "(#{x.inspect})"}.join("*") if coefficient == 1
    coefficient.inspect + "*" + terms.map {|x| "(#{x.inspect})"}.join("*")
  end
end

def var(x)
  Variable.new(x)
end

def const(x)
  Constant.new(x)
end

def sum(*args)
  Sum.new(args)
end

def product(coefficient,*args)
  Product.new(coefficient, args)
end

p product(1,sum(var(:x),var(:y)),var(:z))