namespace :import do
  desc "Import recipes from public/recipes-en.json file"
  task recipes: :environment do
    file_path = Rails.root.join("public", "recipes-en.json")

    recipes = JSON.parse(File.read(file_path))

    batch = recipes.map do |recipe|
      new_recipe = recipe.slice(
        "cook_time",
        "prep_time",
        "ratings",
        "title",
        "image",
        "category",
        "author",
        "ingredients"
      )
      new_recipe["ingredients_text"] = new_recipe["ingredients"].join(",")
      new_recipe["created_at"] = Time.now.to_s
      new_recipe["updated_at"] = Time.now.to_s
      new_recipe
    end

    Recipe.insert_all(batch)
  end
end
