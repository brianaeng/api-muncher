require "#{Rails.root}/lib/edamam_api_wrapper.rb"
require "#{Rails.root}/lib/recipe.rb"

class HomepagesController < ApplicationController

  def index
    @health_options = ["vegan", "vegetarian", "paleo", "dairy-free", "gluten-free", "wheat-free", "fat-free", "low-sugar", "egg-free", "peanut-free", "tree-nut-free", "soy-free", "fish-free", "shellfish-free"]

    session[:searches] ||= []

    if session[:searches].length > 4
      @searches = session[:searches][-5..-1].reverse
    else
      @searches = session[:searches].reverse
    end

    if params[:commit] != nil
      search_results
    end
  end

  def search_results
    if params[:num_pages] != nil
      @num_pages = params[:num_pages].to_i
    else
      @total_results = EdamamApiWrapper.find_recipes(params[:search_term], params["health_terms"])

      @num_pages = @total_results.length/10
    end

    @from_value = (params[:page_num].to_i * 10) - 10
    @to_value = params[:page_num].to_i * 10

    @results = EdamamApiWrapper.find_recipes(params[:search_term], params["health_terms"], @from_value, @to_value)

    session[:searches].push(params[:search_term])
  end

  def show
    response = params[:recipe_uri]
    id = response.split("_")[-1]
    recipe_uri = "https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_" + id

    @recipe = EdamamApiWrapper.get_recipe(recipe_uri)
  end

end
