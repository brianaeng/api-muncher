require 'httparty'

class Edamam_Api_Wrapper
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]
  BASE_URL = "https://api.edamam.com/search"
  MAX_NUM_RESULTS = 100 #Keeping this as 20 for now since default is only 10, can increase later


  def self.find_recipes(search_term, from = 0, to = MAX_NUM_RESULTS)
    #Compiled URL with constants and given search term
    url = BASE_URL + "?q=#{search_term}" + "&app_id=#{ID}&app_key=#{KEY}" + "&from=#{from}&to=#{to}"

    #Using HTTParty to get URL response
    response = HTTParty.get(url)

    recipes = []

    #Will return recipe instances
    response["hits"].each do |recipe|
      recipe_instance = Recipe.new(recipe["recipe"]["label"], recipe["recipe"]["url"], recipe["recipe"]["image"], recipe["recipe"]["ingredients"], recipe["recipe"]["healthLabels"])

      recipes.push(recipe_instance)
    end

    return recipes

  end
end
