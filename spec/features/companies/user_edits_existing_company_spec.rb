require 'rails_helper'

describe "User edits an existing company" do
  scenario "a user can edit a company" do
    company = Company.create!(name: "ESPN")
    visit edit_company_path(company)

    fill_in "company[name]", with: "EA Sports"
    click_button "Update"

    expect(current_path).to eq("/companies/#{Company.last.id}/jobs")
    expect(page).to have_content("EA Sports")
    expect(page).to_not have_content("ESPN")
  end
  scenario "a user attempts to edit a company with duplicate entry" do
    company1 = Company.create!(name: 'ESPN')
    company2 = Company.create!(name: 'ESPN 2')

    visit edit_company_path(company2)

    fill_in "company[name]", with: "ESPN"
    click_button "Update"

    expect(current_path).to eq(edit_company_path(company2))
    expect(page).to have_content("Company 'ESPN' already exists!")
  end
end
