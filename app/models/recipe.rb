class Recipe < ApplicationRecord
  scope :search_ingredients, ->(ingredients) { where("ingredients @> ARRAY[?]::varchar[]", ingredients) }

  def total_time
    @total_time ||= prep_time + cook_time
  end
end
