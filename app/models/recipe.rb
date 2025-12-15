class Recipe < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_ingredients,
                  against: :ingredients_text,
                  using: {
                    tsearch: {
                      tsvector_column: "ingredients_tsv"
                    }
                  }
  def total_time
    @total_time ||= prep_time + cook_time
  end
end
