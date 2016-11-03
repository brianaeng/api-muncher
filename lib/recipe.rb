
class Recipe
  attr_reader :uri, :name, :link, :image, :ingredients, :dietary_info

  def initialize(uri, name, link, image, ingredients, dietary_info)
    @uri = uri
    @name = name
    @link = link
    @image = image
    @ingredients = ingredients
    @dietary_info = dietary_info

    if ([uri, name, link, image, ingredients, dietary_info].include? nil) || ([uri, name, link, image, ingredients, dietary_info].include? "")
      raise ArgumentError
    end
  end

end
