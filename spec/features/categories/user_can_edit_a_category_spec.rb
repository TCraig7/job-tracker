require 'rails_helper'

describe 'User can edit a category' do
  scenario 'a user clicks edit on category index page' do
    category = Category.create!(name: 'Legal')

    visit categories_path

    click_link "Edit"

    expect(current_path).to eq(edit_category_path(category))

    fill_in "category[name]", with: "Finance"

    click_button "Update Category"

    expect(page).to have_content("Finance")
  end
end
