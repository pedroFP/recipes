class AddRecipesIngredientsIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :recipes,
          "to_tsvector('simple', ingredients_text)",
          using: :gin,
          name: "ingredients_text_index"
  end
end
