require "#{Rails.root}/lib/edamam_api_wrapper.rb"
require "#{Rails.root}/lib/recipe.rb"

class HomepagesController < ApplicationController

  def index
    @health_options = ["vegan", "vegetarian", "sugar-conscious", "peanut-free", "tree-nut-free", "alcohol-free"]
    @diet_options = ["balanced", "high-protein", "low-fat", "low-carb"]

    session[:searches] ||= []

    session[:searches].delete("")

    if session[:searches].length > 4
      @searches = session[:searches][-3..-1].reverse
    else
      @searches = session[:searches].reverse
    end
  end

  def search_results
    if params[:num_pages] != nil
      @num_pages = params[:num_pages].to_i
    else
      @total_results = EdamamApiWrapper.find_recipes(params[:search_term], params["health_terms"], params["diet_terms"])

      @num_pages = @total_results.length/10
    end

    @from_value = (params[:page_num].to_i * 10) - 10
    @to_value = params[:page_num].to_i * 10

    @results = EdamamApiWrapper.find_recipes(params[:search_term], params["health_terms"], params["diet_terms"], @from_value, @to_value)

    if session[:searches]
      session[:searches].push(params[:search_term])
    end
  end

  def show
    response = params[:recipe_uri]
    id = response.split("_")[-1]
    recipe_uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_" + id

    response = EdamamApiWrapper.get_recipe(recipe_uri)

    @recipe = Recipe.new(response[0]["uri"], response[0]["label"], response[0]["url"], response[0]["image"], response[0]["ingredients"], response[0]["healthLabels"], response[0]["dietLabels"])
  end

end
