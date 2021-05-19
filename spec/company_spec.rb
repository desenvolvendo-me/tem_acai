RSpec.describe Company do
  context ".create" do
    it "creates a company with id, name and phone" do
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111")

      expect(company[:name]).to eq("Casa do Açaí")
      expect(company[:phone]).to eq("11-11111111")
      expect(company[:id]).to be_truthy
    end
  end
end
