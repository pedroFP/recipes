class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.float :cook_time
      t.float :prep_time
      t.float :ratings
      t.string :title
      t.string :image
      t.string :category
      t.string :author
      t.text :ingridients_text
      t.string :ingredients, array: true, default: []

      t.timestamps
    end
  end
end
