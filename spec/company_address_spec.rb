# frozen_string_literal: true

RSpec.describe CompanyAddress do
  csv_path = "spec/support/companies-addresses-test.csv"

  before do
    stub_const("CompanyAddress::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  context "create" do
    it "address attributes" do
      company_address = CompanyAddress.create(company_id: "123", zip: "11111-111", street: "Rua do Açaí, 25",
                                              city: "São Paulo", state: "SP")

      expect(company_address.company_id).to eq("123")
      expect(company_address.street).to eq("Rua do Açaí, 25")
      expect(company_address.zip).to eq("11111-111")
      expect(company_address.city).to eq("São Paulo")
      expect(company_address.state).to eq("SP")
    end
  end

  context "find" do
    it "by company id" do
      CompanyAddress.create(company_id: "123", zip: "11111-111", street: "Rua do Açaí, 25", city: "São Paulo",
                            state: "SP")

      address = CompanyAddress.from_company("123")

      expect(address.street).to eq("Rua do Açaí, 25")
      expect(address.zip).to eq("11111-111")
      expect(address.city).to eq("São Paulo")
      expect(address.state).to eq("SP")
    end
  end

  context "not create" do
    it "zip empty" do
      company_address = CompanyAddress.create(company_id: "123", zip: "", street: "Rua do Açaí, 25", city: "São Paulo",
                                             state: "SP")
      expect(company_address).to eq("O cep é obrigatório")
    end

    it "state empty " do
      company_address = CompanyAddress.create(company_id: "123", zip: "1111-1111", street: "Rua do Açaí, 25",
                                             city: "São Paulo", state: "")
      expect(company_address).to eq("O estado é obrigatório")
    end

    it "city empty" do
      company_address = CompanyAddress.create(company_id: "123", zip: "1111-1111", street: "Rua do Açaí, 25", city: "",
                                             state: "SP")
      expect(company_address).to eq("A cidade é obrigatória")
    end

    it "street empty" do
      company_address = CompanyAddress.create(company_id: "123", zip: "1111-1111", street: "", city: "São Paulo",
                                             state: "SP")
      expect(company_address).to eq("A rua é obrigatória")
    end
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id company_id zip street city state]
    end
  end
end
