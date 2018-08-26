require 'rails_helper'

describe Company do
  describe "Class Methods" do
    it ".company_by_interest" do
      company1 = Company.create!(name: 'ESPN')
      company2 = Company.create!(name: 'Google')
      company3 = Company.create!(name: 'Twitter')
      company4 = Company.create!(name: 'GoDaddy')
      category = Category.create!(name: 'Something')
      job1 = company1.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 4, city: 'Denver', category_id: category.id)
      job2 = company1.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Denver', category_id: category.id)
      job3 = company2.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 3, city: 'Denver', category_id: category.id)
      job4 = company2.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 4, city: 'Boulder', category_id: category.id)
      job5 = company2.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Boulder', category_id: category.id)
      job6 = company3.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 3, city: 'Reno', category_id: category.id)
      job7 = company3.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 1, city: 'Reno', category_id: category.id)
      job8 = company3.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Atlanta', category_id: category.id)
      job9 = company4.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 2, city: 'Portland', category_id: category.id)

      companies_by_interest = Company.companies_by_interest

      expect(companies_by_interest[0].avg_interest).to eq(4.5)
      expect(companies_by_interest[1].avg_interest).to eq(4)
      expect(companies_by_interest[2].avg_interest).to eq(3)
      expect(companies_by_interest.size).to eq(3)
    end
  end
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a name" do
        company = Company.new()
        expect(company).to be_invalid
      end

      it "has a unique name" do
        Company.create(name: "Dropbox")
        company = Company.new(name: "Dropbox")
        expect(company).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a name" do
        company = Company.new(name: "Dropbox")
        expect(company).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many jobs" do
      company = Company.new(name: "Dropbox")
      expect(company).to respond_to(:jobs)
    end
    it { should have_many :contacts}
  end
end
