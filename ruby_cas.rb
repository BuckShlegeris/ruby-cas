class Expression

end

# Make setters, getters, equality testing, initialize.
def magic_metaprogram(*args)

  # Initialize
  inside_string = args.map do |arg|
    "@#{arg} = #{arg};"
  end.join(" ")

  self.class_eval "def initialize(#{args.join(",")}); #{inside_string}; end"

  # Equality testing
  inside_string = args.map do |arg|
    "return false unless #{arg} == other.#{arg};"
  end.join(" ")
  self.class_eval "def ==(other); #{inside_string}; return true; end"

  args.each do |arg|
    # Getter
    self.class_eval("def #{arg}; @#{arg}; end")

    # Setter
    self.class_eval("def #{arg}=(x); @#{arg}=x; end")
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

  def initialize(*terms)
    @terms = terms
  end

  def inspect
    terms.map(&:inspect).join("+")
  end
end

v = Variable.new("x")
q = Variable.new("x")
c = Constant.new(45)
s = Sum.new(v, c)
p s