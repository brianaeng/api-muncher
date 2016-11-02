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

  test 'a search with no results from Edamam is empty' do
    VCR.use_cassette("empty results") do
      no_recipes = EdamamApiWrapper.find_recipes("sdbfsdnfjksnjfsd", 0, 10)

      assert_equal no_recipes, []
    end
  end

  test 'results cannot be retrieved from Edamam with a bad id' do
    VCR.use_cassette("bad id") do
      response = EdamamApiWrapper.find_recipes("tomato", 0, 10, 234234, nil)

      assert response.parsed_response.include? ("Error 401")
    end
  end

  test 'results cannot be retrieved from Edaman with a bad key' do
    VCR.use_cassette("bad key") do
      response = EdamamApiWrapper.find_recipes("tomato", 0, 10, 234234, nil)

      assert response.parsed_response.include? ("Error 401")
    end
  end

end
