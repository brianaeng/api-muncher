
class Recipe
  attr_reader :name, :link, :picture_url, :ingredients, :dietary_info

  def initialize(name, link, picture_url, ingredients, dietary_info)
    @name = name
    @link = link
    @picture_url = picture_url
    @ingredients = ingredients
    @dietary_info = dietary_info

    if ([name, link, picture_url, ingredients, dietary_info].include? nil) || ([name, link, picture_url, ingredients, dietary_info].include? "")
      raise ArgumentError
    end
  end

end
