require 'rails_helper'

describe "User can edit a job" do
  scenario "a user clicks edit on company job page" do
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver")

    visit company_path(company)

    click_link "Edit"

    expect(current_path).to eq(edit_company_job_path(company, job))

    fill_in "job[title]", with: "Analyst"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 5
    fill_in "job[city]", with: "San Francisco"

    click_button "Update"

    expect(current_path).to eq(company_job_path(company, job))
    expect(page).to have_content("Analyst")
    expect(page).to have_content("So fun!")
    expect(page).to have_content("5")
    expect(page).to have_content("San Francisco")
  end
end
