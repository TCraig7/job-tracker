require 'rails_helper'

describe 'User sees all jobs' do
  scenario 'a user sees all jobs' do
    company1 = Company.create!(name: 'Company 1')
    company2 = Company.create!(name: 'Company 2')
    category = Category.create!(name: 'Category 1')
    job1 = company1.jobs.create!(title: 'Developer', description: 'None', level_of_interest: 5, city: 'Denver', category_id: category.id)
    job2 = company1.jobs.create!(title: 'Analyst', description: 'One', level_of_interest: 3, city: 'Dallas', category_id: category.id)
    job3 = company2.jobs.create!(title: 'Mailman', description: 'All', level_of_interest: 4, city: 'Brussels', category_id: category.id)

    visit jobs_path

    expect(page).to have_content(job1.title)
    expect(page).to have_content(job1.company.name)
    within("#level-of-interest-job-#{job1.id}") do
      expect(page).to have_content(job1.level_of_interest)
    end
    expect(page).to have_content(job1.city)
    expect(page).to have_content(job2.title)
    expect(page).to have_content(job2.company.name)
    within("#level-of-interest-job-#{job2.id}") do
      expect(page).to have_content(job2.level_of_interest)
    end
    expect(page).to have_content(job2.city)
    expect(page).to have_content(job3.title)
    expect(page).to have_content(job3.company.name)
    within("#level-of-interest-job-#{job3.id}") do
      expect(page).to have_content(job3.level_of_interest)
    end
    expect(page).to have_content(job3.city)
  end

  describe 'User can filter jobs' do
    scenario 'filter by location' do
      company = Company.create!(name: "Google")
      category = Category.create!(name: "Developer")
      job1 = company.jobs.create!(title: "Junior Dev", description: "Junior Dev", level_of_interest: 4, city: "Boulder", category_id: category.id)
      job2 = company.jobs.create!(title: "Junior Dev Ops", description: "Junior Dev Ops", level_of_interest: 3, city: "Boulder", category_id: category.id)
      job3 = company.jobs.create!(title: "Junior Dev - remote", description: "Junior Dev - remote", level_of_interest: 5, city: "Denver", category_id: category.id)

      visit "/jobs?location=Boulder"

      expect(page).to have_content(job1.title)
      expect(page).to have_content(job2.title)
      expect(page).to_not have_content(job3.title)
    end

    scenario 'sorted by level of interest' do
      company = Company.create!(name: "Google")
      category = Category.create!(name: "Developer")
      job1 = company.jobs.create!(title: "Junior Dev", description: "Junior Dev", level_of_interest: 3, city: "Boulder", category_id: category.id)
      job2 = company.jobs.create!(title: "Junior Dev Ops", description: "Junior Dev Ops", level_of_interest: 2, city: "Boulder", category_id: category.id)
      job3 = company.jobs.create!(title: "Junior Dev - remote", description: "Junior Dev - remote", level_of_interest: 5, city: "Denver", category_id: category.id)

      visit jobs_path

      click_link "Interest"

      Capybara.ignore_hidden_elements = false
      within("#sorted-jobs") do
        expect(page).to have_text("#{job3.title}\n#{job1.title}\n#{job2.title}")
      end
    end
  end
end
