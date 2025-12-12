class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all.limit(20)
  end
end
