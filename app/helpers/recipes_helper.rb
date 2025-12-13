module RecipesHelper
  def star_icons(value, from: 0, to: 5)
    stars = Array.new(to, content_tag(:i, "", class: "bi bi-star"))
    value_int = value.to_i
    value_int.times { |index| stars[index] = content_tag(:i, "", class: "bi bi-star-fill") }
    stars[value_int] = content_tag(:i, "", class: "bi bi-star-half") if value > value_int
    stars
  end
end