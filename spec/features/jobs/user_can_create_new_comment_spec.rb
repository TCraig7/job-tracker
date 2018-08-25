require 'rails_helper'

describe 'User can comment on jobs' do
  scenario 'user views job show page and comments' do
    category = Category.create!(name: 'Test Category')
    company = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver', category_id: category.id)

    visit company_job_path(company, job)

    fill_in "comment[content]", with: "Talked to hiring manager."
    click_on "Save"

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content("Talked to hiring manager.")
  end
end
