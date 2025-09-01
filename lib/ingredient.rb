class Ingredient
  attr_reader :name, :vegetarian

  def initialize(name, vegetarian: true)
    @name = name
    @vegetarian = vegetarian
  end

  def vegetarian?
    @vegetarian
  end
end
