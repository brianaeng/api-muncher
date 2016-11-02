require "#{Rails.root}/lib/edamam_api_wrapper.rb"
require "#{Rails.root}/lib/recipe.rb"
require 'will_paginate/array'


class HomepagesController < ApplicationController

  def index
  end

  def search_results
    @results = Edamam_Api_Wrapper.find_recipes(params[:search_term]).paginate(:page => params[:page], per_page: 10)

    # Attempt to save results via session but the hash was too big (even when JSON?) to store
    # if session[:search_results] != nil
    #   @pages = JSON.parse(session[:search_results])
    #   @num_pages = @pages.length
    # else
    #   @results = Edamam_Api_Wrapper.find_recipes(params[:search_term])
    #
    #   @num_pages = @results.length/10
    #   max_num = 10
    #   page_num = 1
    #
    #   @pages = {}
    #
    #   @num_pages.times do
    #     @page_results = @results[0..max_num]
    #     @pages["#{page_num}"] = @page_results
    #     max_num += 10
    #     page_num += 1
    #   end
    #
    #   session[:search_results] = @pages.to_json
    # end
  end

  def show
    @recipe_name = params[:recipe_name]
    @recipe_link = params[:recipe_link]
    @recipe_image = params[:recipe_image]
    @recipe_ingredients = params[:recipe_ingredients]
    @recipe_dietary_info = params[:recipe_dietary_info]
  end

  private
  def recipe_params
    params.permit(:name, :user_id, :price, :quantity, :description, :picture, :active, categories_attributes: [:name], category_ids: [])
  end
end
