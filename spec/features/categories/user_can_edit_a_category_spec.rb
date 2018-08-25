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

  scenario 'User edits a category with duplicate name' do
    category_1 = Category.create!(name: 'Legal')
    category_2 = Category.create!(name: 'Finance')

    visit edit_category_path(category_2)

    fill_in "category[name]", with: "Legal"

    click_button "Update Category"

    expect(current_path).to eq(edit_category_path(category_2))
    expect(page).to have_content("Sorry, this category name already exists!")
  end
end
