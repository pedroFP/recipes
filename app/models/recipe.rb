class Recipe < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_ingredients,
                  against: :ingredients_text,
                  using: {
                    tsearch: {
                      tsvector_column: "ingredients_tsv"
                    }
                  }

  # before_save :update_ingredients_text

  def total_time
    @total_time ||= prep_time + cook_time
  end

  private

  # def update_ingredients_text
  #   self.ingredients_text = self.ingredients.join(",")
  # scope :search_ingredients, ->(ingredients) { where("ingredients @> ARRAY[?]::varchar[]", ingredients) }
end
