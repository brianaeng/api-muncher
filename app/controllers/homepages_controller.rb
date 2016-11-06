require "#{Rails.root}/lib/edamam_api_wrapper.rb"
require "#{Rails.root}/lib/recipe.rb"

class HomepagesController < ApplicationController

  def index
    @health_options = ["vegan", "vegetarian", "peanut-free", "tree-nut-free"]
    @diet_options = ["balanced", "high-protein", "low-fat", "low-carb"]

    #Finds session searches or creates new
    session[:searches] ||= []

    #Deletes any blank searches
    session[:searches].delete("")

    #Displays only the three most recent or all (if less than 3)
    if session[:searches].length > 2
      @searches = session[:searches][-3..-1].reverse
    else
      @searches = session[:searches].reverse
    end
  end

  def search_results
    #If the number of pages is passed it doesn't need to find that number again
    if params[:num_pages] != nil
      @num_pages = params[:num_pages].to_i
    #Else that means this is the first search & should get the full amount to calc number of pages
    else
      @total_results = EdamamApiWrapper.find_recipes(params[:search_term], params["health_terms"], params["diet_terms"])

      @num_pages = @total_results.length/10
    end

    #Calc the "to" and "from" attributes based on page number
    @from_value = (params[:page_num].to_i * 10) - 10
    @to_value = params[:page_num].to_i * 10

    #Gets the results via HTTParty after getting all the attributes
    @results = EdamamApiWrapper.find_recipes(params[:search_term], params["health_terms"], params["diet_terms"], @from_value, @to_value)

    #Adds the search to the session searches
    if session[:searches]
      session[:searches].push(params[:search_term])
    end
  end

  def show
    #Grabs the recipe uri passed in from the results page
    response = params[:recipe_uri]

    #Splits the uri to just get the random letters/numbers section
    id = response.split("_")[-1]

    #Generates uri to pass through HTTParty
    recipe_uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_" + id

    #Sends uri to HTTParty
    response = EdamamApiWrapper.get_recipe(recipe_uri)

    #Creates recipe instance based on response from HTTParty
    @recipe = Recipe.new(response[0]["uri"], response[0]["label"], response[0]["url"], response[0]["image"], response[0]["ingredients"], response[0]["healthLabels"], response[0]["dietLabels"])
  end

end
