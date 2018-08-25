require 'rails_helper'

describe 'User can delete a category' do
  scenario 'user deletes category from category index page' do
    category1 = Category.create!(name: 'Finance')
    category2 = Category.create!(name: 'Legal')

    visit categories_path

    find("#category-id-#{category2.id}").click

    expect(current_path).to eq(categories_path)
    expect(page).to have_content(category1.name)
    expect(page).to_not have_content(category2.name)
  end
end
