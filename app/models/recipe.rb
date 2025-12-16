class Recipe < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_ingredients,
                  against: :ingredients_text,
                  using: {
                    tsearch: {
                      tsvector_column: "ingredients_tsv"
                    }
                  }
  belongs_to :user

  validates :cook_time,
            :prep_time,
            :title,
            :image,
            :category,
            :author,
            :ingredients,
            presence: true
  
  def total_time
    @total_time ||= prep_time + cook_time
  end
end
