require "#{Rails.root}/lib/edamam_api_wrapper.rb"
require "#{Rails.root}/lib/recipe.rb"

class HomepagesController < ApplicationController

  def index
    #Tentatively thinking to use this for the homepage, where the search bar sits
  end

  def search_results
    #Tentatively thinking to use this for search results
    if params[:results] != nil
      @pages = params[:results]
      @num_pages = @pages.length
    else
      @results = Edamam_Api_Wrapper.find_recipes(params[:search_term])

      @num_pages = @results.length/10
      @max_num = 10
      @page_num = 1

      @pages = {}

      @num_pages.times do
        @page_results = @results[0..@max_num]
        @pages[@page_num] = @page_results
        @max_num += 10
        @page_num += 1
      end
    end

    #Need a way to pass remaining results on to next page?
    # if params[:page_num] != 1
    #   @pages = params[:results]
    # end
  end

  def show
    #Tentatively thinking to use this for each recipe show
    @recipe_name = params[:recipe_name]
    @recipe_link = params[:recipe_link]
    @recipe_image = params[:recipe_image]
    @recipe_ingredients = params[:recipe_ingredients]
    @recipe_dietary_info = params[:recipe_dietary_info]
  end
end
