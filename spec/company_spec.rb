RSpec.describe Company do
  context ".create" do
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
      companies = Company.all
      company = Company.create(name: "Casa do Açaí")
      new_companies = Company.all

      expect(companies).to be_empty
      expect(new_companies.size).to eq 1
      expect(new_companies.to_s).to include("Casa do Açaí")
    end
  end
end
