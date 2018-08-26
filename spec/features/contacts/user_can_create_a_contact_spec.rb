require 'rails_helper'

describe 'Company show page shows contact information' do
  scenario 'user adds new company contact information for company' do
    company = Company.create!(name: 'ESPN')

    visit company_path(company)

    fill_in "contact[name]", with: "Bob Ross"
    fill_in "contact[position]", with: "On Staff Painter"
    fill_in "contact[email]", with: "bob.ross@gmail.com"

    click_on "Save"

    expect(current_path).to eq(company_path(company))
    expect(page).to have_content("Bob Ross")
    expect(page).to have_content("On Staff Painter")
    expect(page).to have_content("bob.ross@gmail.com")
  end
end
