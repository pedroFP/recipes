module RecipesHelper
  def display_stars(value, from: 0, to: 5)
    stars = Array.new(to, content_tag(:i, "", class: "bi bi-star"))
    value_int = value.to_i
    value_int.times { |index| stars[index] = content_tag(:i, "", class: "bi bi-star-fill") }
    stars[value_int] = content_tag(:i, "", class: "bi bi-star-half") if value > value_int
    tag.span(title: value) do
      safe_join stars
    end
  end

  def display_time(value_in_minutes)
    value_in_hours = (value_in_minutes / 60).round(2)
    message  = value_in_hours > 1 ? "#{value_in_hours} hours" : "#{value_in_minutes} minutes"

    tag.span(title: value_in_hours) do
      safe_join([
        message,
        content_tag(:i, "", class: "mx-2 bi bi-clock")
      ])
    end
  end
end