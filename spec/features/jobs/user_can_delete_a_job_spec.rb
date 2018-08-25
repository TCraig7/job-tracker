require 'rails_helper'

describe 'User can delete a job' do
  scenario 'user clicks delete on a company job page' do
    company = Company.create!(name: 'ESPN')
    job = company.jobs.create!(title: 'Developer', level_of_interest: 70, city: 'Denver')

    visit company_path(company)
    click_on 'Delete'

    expect(page).to_not have_content('Developer')
  end
end
