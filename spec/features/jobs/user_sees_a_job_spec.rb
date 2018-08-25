require 'rails_helper'

describe "User sees a specific job" do
  scenario "a user sees a job for a specific company" do
    category = Category.create!(name: 'Test Category')
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)

    visit company_job_path(company, job)

    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
    expect(page).to have_content("70")
  end

  scenario "a user can see comments for a specific job" do
    category = Category.create!(name: 'Test Category')
    company = Company.create!(name: "ESPN")
    job = company.jobs.create!(title: "Developer", level_of_interest: 70, city: "Denver", category_id: category.id)
    comment_1 = job.comments.create!(content: "Called hiring manager.")
    comment_2 = job.comments.create!(content: "Hiring manager left vm.")

    visit company_job_path(company, job)

    expect(page).to have_content(comment_1.content)
    expect(page).to have_content(comment_2.content)
  end
end
