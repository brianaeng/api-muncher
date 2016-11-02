

class EdamamApiWrapperTest < ActionController::TestCase

  test 'all search results can be retrieved from Edamam' do
    VCR.use("all recipes") do
      all_recipes = Edamam_Api_Wrapper.find_recipes("tomato")

      assert all_recipes.is_a? Array
      assert all_recipes.length > 0
    end
  end

  test 'a group of 10 results can be retrieved from Edamam' do
    VCR.use("ten recipes") do
      ten_recipes = Edamam_Api_Wrapper.find_recipes("tomato", 0, 10)

      assert_equal all_recipes.length, 10
    end
  end
end
