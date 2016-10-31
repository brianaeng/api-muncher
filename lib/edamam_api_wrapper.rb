class Edamam_Api_Wrapper
  ID = ENV["APP_ID"]
  KEY = ENV["APP_KEY"]
  BASE_URL = "https://api.edamam.com/search"

  def self.find_recipes(search_term)
    url = BASE_URL + "?q=#{search_term}" + "&app_id=#{ID}&app_key=#{KEY}"

    response = HTTParty.get(url)
  end

end
