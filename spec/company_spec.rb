# frozen_string_literal: true

RSpec.describe Company do
  context ".create" do
    csv_path = "spec/support/companies-test.csv"

    before do
      stub_const("Company::DATA_PATH", csv_path)
      restart_csv(csv_path)
    end

    after(:all) { restart_csv(csv_path) }

    it "creates a company with id, name and phone" do
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111")

      expect(company.name).to eq("Casa do Açaí")
      expect(company.phone).to eq("11-11111111")
      expect(company.id).to be_truthy
    end

    it "without a phone" do
      company = Company.create(name: "Casa do Açaí")

      expect(company.name).to eq("Casa do Açaí")
      expect(company.phone).to eq("")
    end

    it "persists the data" do
      companies = Company.all
      Company.create(name: "Casa do Açaí")
      new_companies = Company.all

      expect(companies).to be_empty
      expect(new_companies.first.name).to eq("Casa do Açaí")
    end
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id name phone]
    end
  end
end
