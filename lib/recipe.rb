
class Recipe
  attr_reader :uri, :name, :link, :image, :ingredients, :health_info, :diet_info

  def initialize(uri, name, link, image, ingredients, health_info, diet_info)
    @uri = uri
    @name = name
    @link = link
    @image = image
    @ingredients = ingredients
    @health_info = health_info
    @diet_info = diet_info

    #Checks to see if any info is blank
    if ([uri, name, link, image, ingredients, health_info, diet_info].include? nil) || ([uri, name, link, image, ingredients, health_info, diet_info].include? "")
      raise ArgumentError
    end
  end

end
