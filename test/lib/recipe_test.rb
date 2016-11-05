require 'test_helper'
require 'recipe'

class RecipeTest < ActionController::TestCase
  test "the truth" do
    assert true
  end

  test "a recipe without a URI cannot be created" do
    assert_raise ArgumentError do
      Recipe.new(nil, "name", "link", "image", "ingredients", "dietary_info")
    end
  end

  test "a recipe without a name cannot be created" do
    assert_raise ArgumentError do
      Recipe.new("uri", nil, "link", "image", "ingredients", "dietary_info")
    end
  end

  test "a recipe without a link cannot be created" do
    assert_raise ArgumentError do
      Recipe.new("uri", "name", nil, "image", "ingredients", "dietary_info")
    end
  end

  test "a recipe without an image cannot be created" do
    assert_raise ArgumentError do
      Recipe.new("uri", "name", "link", nil, "ingredients", "dietary_info")
    end
  end

  test "a recipe without ingredients cannot be created" do
    assert_raise ArgumentError do
      Recipe.new("uri", "name", "link", "image", nil, "dietary_info")
    end
  end

  test "a recipe without dietary info cannot be created" do
    assert_raise ArgumentError do
      Recipe.new("uri", "name", "link", "image", "ingredients", nil)
    end
  end

  test "a recipe can successfully be created with all attributes" do
    test_recipe = Recipe.new("uri", "name", "link", "image", "ingredients", "dietary_info")
    assert test_recipe
  end

  test "a recipe's attribute is correctly set" do
    test_recipe = Recipe.new("uri", "name", "link", "image", "ingredients", "dietary_info")
    assert_equal test_recipe.name, "name"
  end
end
