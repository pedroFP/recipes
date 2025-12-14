class Recipe < ApplicationRecord

  def total_time
    @total_time ||= prep_time + cook_time
  end
end
