require 'rails_helper'

describe Job do
  before(:each) do
    @category = Category.create!(name: 'Some Category')
  end
  describe "Class Methods" do
    it ".count_by_location" do
      company = Company.create!(name: 'ESPN')
      category = Category.create!(name: 'Something')
      job1 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Denver', category_id: category.id)
      job2 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Denver', category_id: category.id)
      job3 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Denver', category_id: category.id)
      job4 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Boulder', category_id: category.id)
      job5 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Boulder', category_id: category.id)
      job6 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Reno', category_id: category.id)
      job7 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Reno', category_id: category.id)
      job8 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Atlanta', category_id: category.id)
      job9 = company.jobs.create!(title: 'Dev', description: 'None', level_of_interest: 5, city: 'Portland', category_id: category.id)

      jobs_by_location = Job.count_by_location

      expect(jobs_by_location["Denver"]).to eq 3
      expect(jobs_by_location["Boulder"]).to eq 2
      expect(jobs_by_location["Reno"]).to eq 2
      expect(jobs_by_location["Atlanta"]).to eq 1
      expect(jobs_by_location["Portland"]).to eq 1
    end
  end
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo", city: "Denver", category_id: @category.id)
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo", city: "Denver", category_id: @category.id)
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 80, category_id: @category.id)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, and company" do
        company = Company.new(name: "Turing")
        job = Job.new(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category_id: @category.id)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo", category_id: @category.id)
      expect(job).to respond_to(:company)
    end
    it { should belong_to(:category) }
    it { should have_many(:comments) }
  end
end
