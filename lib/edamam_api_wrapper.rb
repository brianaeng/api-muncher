require 'httparty'

class EdamamApiWrapper
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]
  BASE_URL = "https://api.edamam.com/search"
  MAX_NUM_RESULTS = 100

  def self.find_recipes(search_term, health_terms = nil, diet_terms = nil, from = 0, to = MAX_NUM_RESULTS, id = nil, key = nil)
    #Sets key and id if both are nil
    id = ID if id == nil
    key = KEY if key == nil

    #URL to be compiled based on arguments given
    url = BASE_URL + "?q=#{search_term}"

    #If health terms given, add them to URL
    if health_terms != nil
      health = ""

      health_terms.each do |term|
        health += "&health=#{term}"
      end

      url += health

    #If diet terms given, add them to URL
    elsif diet_terms != nil
      diet = ""

      diet_terms.each do |term|
        diet += "&diet=#{term}"
      end

      url += diet
    end

    #Add other data to end after optional parameters compiled
    url += "&app_id=#{id}&app_key=#{key}" + "&from=#{from}&to=#{to}"

    #Using HTTParty to get URL response
    response = HTTParty.get(url)

    #initialize recipes array
    recipes = []

    #If the response doesn't include the count attribute, it's some sort of error so just return that response
    if !response.include?("count")
      return response
    #Else you have some results response (either an empty array or filled array)
    else
      #Will return recipe instances to fill array if the count is 1 or more
      if response["count"] > 0
        response["hits"].each do |recipe|
          recipe_instance = Recipe.new(recipe["recipe"]["uri"], recipe["recipe"]["label"], recipe["recipe"]["url"], recipe["recipe"]["image"], recipe["recipe"]["ingredients"], recipe["recipe"]["healthLabels"], recipe["recipe"]["dietLabels"])

          recipes.push(recipe_instance)
        end
      end
    end

    #Either return an empty array (no hits) or full array of results
    return recipes
  end

  def self.get_recipe(recipe_uri)
    #Generate url for HTTParty based on passed in uri
    url = BASE_URL + "?r=#{recipe_uri}"

    #Use HTTParty to get one recipe
    response = HTTParty.get(url)

    #Return that recipe result
    return response
  end

end
