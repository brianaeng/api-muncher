
class Recipe
  attr_reader :name, :link, :image, :ingredients, :dietary_info

  def initialize(name, link, image, ingredients, dietary_info)
    @name = name
    @link = link
    @image = image
    @ingredients = ingredients
    @dietary_info = dietary_info

    if ([name, link, image, ingredients, dietary_info].include? nil) || ([name, link, image, ingredients, dietary_info].include? "")
      raise ArgumentError
    end
  end

end
