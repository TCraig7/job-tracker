require 'rails_helper'

describe "User creates a new job" do
  scenario "a user can create a new job" do
    category = Category.create!(name: 'Test Category')
    company = Company.create!(name: "ESPN")

    visit company_jobs_path(company)

    click_link 'Add New Job'

    expect(current_path).to eq(new_company_job_path(company))

    select "Test Category", from: "job[category_id]"
    fill_in "job[title]", with: "Developer"
    fill_in "job[description]", with: "So fun!"
    fill_in "job[level_of_interest]", with: 80
    fill_in "job[city]", with: "Denver"

    click_button "Create"

    expect(current_path).to eq(company_job_path(company, Job.last))
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("80")
    expect(page).to have_content("Denver")
  end
  it 'has a link to create new category' do
    company = Company.create!(name: 'ESPN')
    category = Category.create!(name: 'Test Category')

    visit new_company_job_path(company)

    click_link 'Add New Category'

    expect(current_path).to eq(new_category_path)
  end
end
