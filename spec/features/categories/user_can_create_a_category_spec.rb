require 'rails_helper'

describe 'User creates a new category' do
  describe 'user visits category index' do
    scenario 'a user can create a new category' do
      visit categories_path

      click_link 'Create New Category'

      expect(current_path).to eq(new_category_path)

      fill_in 'category[name]', with: 'Finance'
      click_button 'Create Category'

      expect(current_path).to eq(categories_path)
      expect(page).to have_content('Finance added!')
      expect(page).to have_content('Finance')
    end
    scenario 'user cannot create duplicate categories' do
      category = Category.create!(name: 'Finance')
      visit categories_path

      click_link 'Create New Category'

      expect(current_path).to eq(new_category_path)

      fill_in 'category[name]', with: 'Finance'
      click_button 'Create Category'

      expect(current_path).to eq(new_category_path)
      expect(page).to have_content('Sorry, this category name already exists!')
    end
  end
end
