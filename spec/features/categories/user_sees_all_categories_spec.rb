require 'rails_helper'

describe 'User can see all categories' do
  describe 'user visits category index' do
    scenario 'shows all job categories' do
      category_1 = Category.create!(name: 'Finance')
      category_2 = Category.create!(name: 'Legal')

      visit categories_path

      expect(page).to have_content(category_1.name)
      expect(page).to have_content(category_2.name)
    end
  end
end
