class Recipe < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_ingredients,
                  against: :ingredients_text,
                  using: [:tsearch]

  before_save :update_ingredients_text

  private

  def update_ingredients_text
    self.ingredients_text = self.ingredients.join(",")
  end
end
