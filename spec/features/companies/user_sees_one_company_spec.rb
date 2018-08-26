require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company" do
    company = Company.create!(name: "ESPN")

    visit company_path(company)

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content("ESPN")
  end

  scenario 'user sees multiple contacts on company page' do
    company = Company.create!(name: "ESPN")
    contact1 = company.contacts.create!(name: "Bob Ross", position: "On Staff Painter", email: "bob.ross@gmail.com")
    contact2 = company.contacts.create!(name: "Judge Judy", position: "On Staff Judger", email: "judyjudgesyou@gmail.com")

    visit company_path(company)
    save_and_open_page
    expect(page).to have_content(contact1.name)
    expect(page).to have_content(contact1.position)
    expect(page).to have_content(contact1.email)
    expect(page).to have_content(contact2.name)
    expect(page).to have_content(contact2.position)
    expect(page).to have_content(contact2.email)
  end
end
