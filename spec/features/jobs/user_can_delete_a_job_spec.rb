require 'rails_helper'

describe 'User can delete a job' do
  scenario 'user clicks delete on a job page' do
    category = Category.create!(name: 'Test Category')
    company = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category.id)

    visit job_path(job)
    click_on 'Delete'

    expect(page).to_not have_content('Developer')
  end
end
