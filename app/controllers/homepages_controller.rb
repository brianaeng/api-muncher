require "#{Rails.root}/lib/edamam_api_wrapper.rb"
require "#{Rails.root}/lib/recipe.rb"

class HomepagesController < ApplicationController

  def index
    @health_options = ["vegan", "vegetarian", "paleo", "dairy-free", "gluten-free", "wheat-free", "fat-free", "low-sugar", "egg-free", "peanut-free", "tree-nut-free", "soy-free", "fish-free", "shellfish-free"]

    if session[:searches] != nil
      session[:searches]
    else
      session[:searches] = []
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

    #Just a test method to see what the url output is
    # @url = EdamamApiWrapper.show_url(params[:search_term], params["health_terms"], @from_value, @to_value)

    @results = EdamamApiWrapper.find_recipes(params[:search_term], params["health_terms"], @from_value, @to_value)

    session[:searches].push(params[:search_term])
  end

  def temp
  end

  def show
    @recipe_name = params[:recipe_name]
    @recipe_link = params[:recipe_link]
    @recipe_image = params[:recipe_image]
    @recipe_ingredients = params[:recipe_ingredients]
    @recipe_dietary_info = params[:recipe_dietary_info]
  end

end
