# frozen_string_literal: true

RSpec.describe Company do
  context ".create" do
    before do
      test_data_path = "spec/support/companies-test.csv"
      stub_const("Company::DATA_PATH", test_data_path)

      CSV.open(test_data_path, "wb") do |csv|
        csv << %w[id name phone]
        csv.close
      end
    end

    it "creates a company with id, name and phone" do
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111")

      expect(company[:name]).to eq("Casa do Açaí")
      expect(company[:phone]).to eq("11-11111111")
      expect(company[:id]).to be_truthy
    end

    it "without a phone" do
      company = Company.create(name: "Casa do Açaí")

      expect(company[:name]).to eq("Casa do Açaí")
      expect(company[:phone]).to eq("")
    end

    it "persists the data" do
      Company.create(name: "Casa do Açaí")
      new_companies = Company.all

      expect(new_companies.to_s).to include("Casa do Açaí")
    end
  end
end
