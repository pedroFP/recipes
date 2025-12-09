class Recipe < ApplicationRecord
  include PgSearch
  pg_search_scope :search_by_ingridients,
                  against: :ingridients_text,
                  using: [:tsearch]

  before_save :update_ingridients_text

  private

  def update_ingridients_text
    self.ingridients_text = self.ingridients.join(",")
  end
end
