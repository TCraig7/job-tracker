require 'rails_helper'

describe 'A user sees a job tracker dashboard' do
  scenario 'a user sees a count of jobs by location' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(name: 'Something')
    job1 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Denver', category_id: category.id)
    job2 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Denver', category_id: category.id)
    job3 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Denver', category_id: category.id)
    job4 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Boulder', category_id: category.id)
    job5 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Boulder', category_id: category.id)
    job6 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Reno', category_id: category.id)
    job7 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Reno', category_id: category.id)
    job8 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Atlanta', category_id: category.id)
    job9 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Portland', category_id: category.id)

    visit dashboard_path

    within("#job-count-by-location-#{job1.city}") do
      expect(page).to have_content(3)
    end
    within("#job-count-by-location-#{job4.city}") do
      expect(page).to have_content(2)
    end
    within("#job-count-by-location-#{job6.city}") do
      expect(page).to have_content(2)
    end
    within("#job-count-by-location-#{job8.city}") do
      expect(page).to have_content(1)
    end
    within("#job-count-by-location-#{job9.city}") do
      expect(page).to have_content(1)
    end
  end
  scenario 'user sees top 3 companies by interest' do
    
  end
end
