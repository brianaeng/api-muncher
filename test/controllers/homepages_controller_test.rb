require 'test_helper'

class HomepagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    VCR.use_cassette("show recipe") do

      get :show, {recipe_uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_65adeae2e0b552568de6250bd9f29b81"}
      assert_response :success
    end
  end

  test "should get first page of search results" do
    VCR.use_cassette("show search results") do

      get :search_results, {search_term: "chicken", page_num: 1}
      assert_response :success
    end
  end

  test "should get non-first page of search results" do
    VCR.use_cassette("show more search results") do

      get :search_results, {search_term: "chicken", page_num: 2}
      assert_response :success
    end
  end
end
