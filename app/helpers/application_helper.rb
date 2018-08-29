module ApplicationHelper
  def interest_to_star(level_of_interest)
    image_array = []
    level_of_interest.times do
      image_array << image_tag('star.svg', class: 'rating-img')
    end
    return image_array.join
  end
end
