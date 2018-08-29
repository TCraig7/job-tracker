require 'rails_helper'

describe "User can edit a job" do
  scenario "a user clicks edit on job page" do
    category = Category.create!(name: 'Test Category')
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "Developer", level_of_interest: 3, city: "Denver", category_id: category.id)

    visit job_path(job)

    click_link "Edit"

    expect(current_path).to eq(edit_job_path(job))

    fill_in "job[title]", with: "Analyst"
    fill_in "job[description]", with: "So fun!"
    select "5 stars", from: "job[level_of_interest]"
    fill_in "job[city]", with: "San Francisco"

    click_button "Update"

    expect(current_path).to eq(job_path(job))
    expect(page).to have_content("Analyst")
    expect(page).to have_content("So fun!")
    expect(page).to have_css(".rating-img", count: 5)
    expect(page).to have_content("San Francisco")
  end
end
