require 'test_helper'
require 'edamam_api_wrapper'
require 'recipe'

class EdamamApiWrapperTest < ActionController::TestCase

  test 'all search results can be retrieved from Edamam' do
    VCR.use_cassette("all recipes") do
      all_recipes = EdamamApiWrapper.find_recipes("tomato")

      assert all_recipes.is_a? Array
      assert all_recipes.length > 0
      assert all_recipes[0].is_a? Recipe
    end
  end

  test 'a group of 10 results can be retrieved from Edamam' do
    VCR.use_cassette("ten recipes") do
      ten_recipes = EdamamApiWrapper.find_recipes("tomato", 0, 10)

      assert_equal ten_recipes.length, 10
    end
  end

  # Need to find a way for the wrapper to take custom id & key
  # test 'results cannot be retrieved from Edamam with a bad id' do
  #   VCR.use_cassette("bad id") do
  #     resonse = EdamamApiWrapper.find_recipes("tomato", 0, 10, 893274, nil)
  #
  #     assert_select 'title', "Error 401 - Edamam"
  #   end
  # end
end
