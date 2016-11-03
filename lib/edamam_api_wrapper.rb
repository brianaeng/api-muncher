require 'httparty'

class EdamamApiWrapper
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]
  BASE_URL = "https://api.edamam.com/search"
  MAX_NUM_RESULTS = 100 #Keeping this as 20 for now since default is only 10, can increase later

  def self.find_recipes(search_term, health_terms = nil, from = 0, to = MAX_NUM_RESULTS, id = nil, key = nil)
    id = ID if id == nil
    key = KEY if key == nil

    #Compiled URL with constants and given search term
    if health_terms == nil
      url = BASE_URL + "?q=#{search_term}" + "&app_id=#{id}&app_key=#{key}" + "&from=#{from}&to=#{to}"
    else
      health = ""

      health_terms.each do |term|
        health += "&health=#{term}"
      end

      url = BASE_URL + "?q=#{search_term}" + health + "&app_id=#{id}&app_key=#{key}" + "&from=#{from}&to=#{to}"
    end

    #Using HTTParty to get URL response
    response = HTTParty.get(url)

    recipes = []

    if !response.include?("count")
      return response
    else
      #Will return recipe instances
      if response["count"] > 0
        response["hits"].each do |recipe|
          recipe_instance = Recipe.new(recipe["recipe"]["label"], recipe["recipe"]["url"], recipe["recipe"]["image"], recipe["recipe"]["ingredients"], recipe["recipe"]["healthLabels"])

          recipes.push(recipe_instance)
        end
      end
    end

    return recipes

  end

  #Test method to show the url output
  def self.show_url(search_term, health_terms = nil, from = 0, to = MAX_NUM_RESULTS, id = nil, key = nil)
    id = ID if id == nil
    key = KEY if key == nil

    health = ""

    health_terms.each do |term|
      health += "&health=#{term}"
    end

    url = BASE_URL + "?q=#{search_term}" + health + "&app_id=#{id}&app_key=#{key}" + "&from=#{from}&to=#{to}"

    return url
  end
end
