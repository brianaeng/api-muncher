require 'test_helper'
require 'edamam_api_wrapper'
require 'recipe'

class EdamamApiWrapperTest < ActionController::TestCase

  test 'all search results can be retrieved from Edamam with a search term' do
    VCR.use_cassette("all recipes") do
      all_recipes = EdamamApiWrapper.find_recipes("tomato")

      assert all_recipes.is_a? Array
      assert all_recipes.length > 0
      assert all_recipes[0].is_a? Recipe
    end
  end

  test 'all search results can be retrieved from Edamam with a health term' do
    VCR.use_cassette("all recipes with health term") do
      all_recipes = EdamamApiWrapper.find_recipes("tomato", ["peanut-free"])

      assert all_recipes.is_a? Array
      assert all_recipes.length > 0
      assert all_recipes[0].is_a? Recipe
    end
  end

  test 'all search results can be retrieved from Edamam with a diet term' do
    VCR.use_cassette("all recipes with diet term") do
      all_recipes = EdamamApiWrapper.find_recipes("tomato", nil, ["balanced"])

      assert all_recipes.is_a? Array
      assert all_recipes.length > 0
      assert all_recipes[0].is_a? Recipe
    end
  end

  test 'all search results can be retrieved from Edamam with a search, health, and diet term' do
    VCR.use_cassette("all recipes with all terms") do
      all_recipes = EdamamApiWrapper.find_recipes("tomato", ["peanut-free"], ["balanced"])

      assert all_recipes.is_a? Array
      assert all_recipes.length > 0
      assert all_recipes[0].is_a? Recipe
    end
  end

  test 'a group of 10 results can be retrieved from Edamam' do
    VCR.use_cassette("ten recipes") do
      ten_recipes = EdamamApiWrapper.find_recipes("tomato", nil, nil, 0, 10)

      assert_equal ten_recipes.length, 10
      assert ten_recipes[0].is_a? Recipe
    end
  end

  test 'a search with no results from Edamam is empty' do
    VCR.use_cassette("empty results") do
      no_recipes = EdamamApiWrapper.find_recipes("sdbfsdnfjksnjfsd", nil, nil, 0, 10)

      assert_equal no_recipes, []
    end
  end

  test 'results cannot be retrieved from Edamam with a bad id' do
    VCR.use_cassette("bad id") do
      response = EdamamApiWrapper.find_recipes("tomato", nil, nil, 0, 10, 234234, nil)
      assert_equal response.code, 401
      # assert response.parsed_response.include? ("Error 401")
    end
  end

  test 'results cannot be retrieved from Edaman with a bad key' do
    VCR.use_cassette("bad key") do
      response = EdamamApiWrapper.find_recipes("tomato", nil, nil, 0, 10, nil, 234234)
      assert_equal response.code, 401
      # assert response.parsed_response.include? ("Error 401")
    end
  end

  test 'a recipe can be retrieved from Edamam with a good uri' do
    VCR.use_cassette("good recipe") do
      recipe = EdamamApiWrapper.get_recipe("http://www.edamam.com/ontologies/edamam.owl%23recipe_65adeae2e0b552568de6250bd9f29b81")

      assert recipe[0].is_a? Hash
    end
  end

  #Not sure how to test this because the response is just one bracket
  test 'a recipe cannot be retrieved from Edamam with a bad uri' do
    VCR.use_cassette("bad recipe") do
      recipe = EdamamApiWrapper.get_recipe("bad uri")

      assert_equal recipe.body, "["
    end
  end

end
