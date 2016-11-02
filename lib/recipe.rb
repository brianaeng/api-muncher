
class Recipe
  attr_reader :name, :link, :image, :ingredients, :dietary_info

  def initialize(name, link, image, ingredients, dietary_info)
    @name = name
    @link = link
    @image = image
    @ingredients = ingredients
    @dietary_info = dietary_info
  end

end
