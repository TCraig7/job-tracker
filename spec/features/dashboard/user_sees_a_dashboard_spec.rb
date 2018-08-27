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

    visit dashboard_index_path

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
    company1 = Company.create!(name: 'ESPN')
    company2 = Company.create!(name: 'Google')
    company3 = Company.create!(name: 'Twitter')
    company4 = Company.create!(name: 'GoDaddy')
    category = Category.create!(name: 'Something')
    job1 = company1.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 4, city: 'Denver', category_id: category.id)
    job2 = company1.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Denver', category_id: category.id)
    job3 = company2.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 3, city: 'Denver', category_id: category.id)
    job4 = company2.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 4, city: 'Boulder', category_id: category.id)
    job5 = company2.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Boulder', category_id: category.id)
    job6 = company3.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 3, city: 'Reno', category_id: category.id)
    job7 = company3.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 1, city: 'Reno', category_id: category.id)
    job8 = company3.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Atlanta', category_id: category.id)
    job9 = company4.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 2, city: 'Portland', category_id: category.id)

    visit dashboard_index_path

    within("#job-interest-by-company-#{company1.id}") do
      expect(page).to have_content(4.5)
    end
    within("#job-interest-by-company-#{company2.id}") do
      expect(page).to have_content(4)
    end
    within("#job-interest-by-company-#{company3.id}") do
      expect(page).to have_content(3)
    end
  end
  scenario 'user sees all jobs counted, grouped by interest' do
    company1 = Company.create!(name: 'ESPN')
    company2 = Company.create!(name: 'Google')
    company3 = Company.create!(name: 'Twitter')
    company4 = Company.create!(name: 'GoDaddy')
    category = Category.create!(name: 'Something')
    job1 = company1.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 1, city: 'Denver', category_id: category.id)
    job2 = company1.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 1, city: 'Denver', category_id: category.id)
    job3 = company2.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 2, city: 'Denver', category_id: category.id)
    job4 = company2.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 2, city: 'Boulder', category_id: category.id)
    job5 = company2.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 3, city: 'Boulder', category_id: category.id)
    job6 = company3.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 3, city: 'Reno', category_id: category.id)
    job7 = company3.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 3, city: 'Reno', category_id: category.id)
    job8 = company3.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 4, city: 'Atlanta', category_id: category.id)
    job9 = company4.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Portland', category_id: category.id)

    visit dashboard_index_path

    within("#level-of-interest-count-5") do
      expect(page).to have_content(1)
    end
    within("#level-of-interest-count-4") do
      expect(page).to have_content(1)
    end
    within("#level-of-interest-count-3") do
      expect(page).to have_content(3)
    end
    within("#level-of-interest-count-2") do
      expect(page).to have_content(2)
    end
    within("#level-of-interest-count-1") do
      expect(page).to have_content(2)
    end
  end
end
