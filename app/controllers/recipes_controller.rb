class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[ edit update destroy ] 
  before_action :set_recipe, only: %i[ show edit update destroy ]
  before_action :set_searched_recipes

  # GET /recipes or /recipes.json
  def index
    @recipes = if @searched_recipes.present?
                 Recipe.search_by_ingredients(@searched_recipes.join(" & "))
               else
                 Recipe.all
               end

    @pagy, @recipes = pagy(:offset, @recipes)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    authorize @recipe
  end

  # recipe /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user.name || current_user.email.split("@").first
    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    authorize @recipe

    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "recipe was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    authorize @recipe

    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_path, notice: "recipe was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params.expect(:id))
    end

    def set_searched_recipes
      @searched_recipes = params.dig(:recipe, :ingredients) || []
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.expect(recipe: [
        :cook_time,
        :prep_time,
        :title,
        :image,
        :category,
        ingredients: []
      ])
    end
end
