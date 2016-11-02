require "#{Rails.root}/lib/edamam_api_wrapper.rb"
require "#{Rails.root}/lib/recipe.rb"

class HomepagesController < ApplicationController

  def index
  end

  def search_results
    @results = Edamam_Api_Wrapper.find_recipes(params[:search_term])

  end

  def show
    @recipe_name = params[:recipe_name]
    @recipe_link = params[:recipe_link]
    @recipe_image = params[:recipe_image]
    @recipe_ingredients = params[:recipe_ingredients]
    @recipe_dietary_info = params[:recipe_dietary_info]
  end
  
end
