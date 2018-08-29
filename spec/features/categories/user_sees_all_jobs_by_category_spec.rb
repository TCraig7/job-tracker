require 'rails_helper'

describe 'User sees a list of all jobs by category' do
  describe 'User clicks on a category' do
    scenario 'user sees list of all jobs by category' do
      company = Company.create!(name: 'Google')
      category = Category.create!(name: 'Developer')
      job1 = company.jobs.create!(title: 'Junior Developer', description: 'Description', level_of_interest: 5, city: 'San Francisco', category_id: category.id)
      job2 = company.jobs.create!(title: 'Senior Developer', description: 'Senior Description', level_of_interest: 5, city: 'Denver', category_id: category.id)

      visit categories_path

      click_link(category.name)

      expect(current_path).to eq(category_path(category))
      expect(page).to have_content(job1.title)
      expect(page).to have_content(job1.company.name)
      expect(page).to have_content(job1.city)
      within("#level-of-interest-job-#{job1.id}") do
        expect(page).to have_css(".rating-img", count: job1.level_of_interest)
      end
      expect(page).to have_content(job2.title)
      expect(page).to have_content(job2.company.name)
      expect(page).to have_content(job2.city)
      within("#level-of-interest-job-#{job2.id}") do
        expect(page).to have_css(".rating-img", count: job2.level_of_interest)
      end
    end
  end
end
