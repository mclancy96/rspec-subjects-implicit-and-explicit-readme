class Recipe
  attr_reader :name, :ingredients, :steps

  def initialize(name, ingredients = [], steps = [])
    @name = name
    @ingredients = ingredients
    @steps = steps
  end

  def add_ingredient(ingredient)
    @ingredients << ingredient
  end

  def add_step(step)
    @steps << step
  end

  def vegetarian?
    ingredients.all?(&:vegetarian?)
  end

  def ingredient_names
    ingredients.map(&:name)
  end
end
