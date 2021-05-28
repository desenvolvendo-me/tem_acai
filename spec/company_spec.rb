# frozen_string_literal: true

RSpec.describe Company do
  csv_path = "spec/support/companies-test.csv"

  before do
    stub_const("Company::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  context ".create" do
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

    it "is_open is false by default" do
      company = Company.create(name: "Casa do Açaí")

      expect(company.is_open?).to eq false
    end

    it "with acai_price" do
      company = Company.create(name: "Casa do Açaí", acai_price: "12,50")

      expect(company.acai_price).to eq("12,50")
    end

    it "acai_price is not required" do
      company = Company.create(name: "Casa do Açaí")

      expect(company.acai_price).to eq("")
    end

    it "creates a company" do
      companies = Company.all
      Company.create(name: "Casa do Açaí", phone: "11-11111111")
      new_companies = Company.all

      expect(companies).to be_empty
      expect(new_companies.first.name).to eq("Casa do Açaí")
      expect(new_companies.first.phone).to eq("11-11111111")
      expect(new_companies.first.id).to be_truthy
    end

    it "creates four companies" do
      Company.create(name: "Casa do Açaí")
      Company.create(name: "Toca do Açaí")
      Company.create(name: "Açaí da Esquina")
      Company.create(name: "Tudo Açaí")
      companies = Company.all

      expect(companies.length).to eq(4)
    end
  end

  context ".all" do
    it "lists one Company with id, name, phone, is_open, id and acai_price" do
      Company.create(name: "Casa do Açaí", phone: "11-11111111", acai_price: "12,00")

      companies = Company.all

      expect(companies.size).to eq 1
      expect(companies.first.name).to eq("Casa do Açaí")
      expect(companies.first.phone).to eq("11-11111111")
      expect(companies.first.is_open?).to eq(false)
      expect(companies.first.acai_price).to eq("12,00")
      expect(companies.first.id).to be_truthy
    end

    it "lists three Companies" do
      Company.create(name: "Casa do Açaí")
      Company.create(name: "Toca do Açaí")
      Company.create(name: "Açaí da Esquina")

      companies = Company.all

      expect(companies.length).to eq(3)
      expect(companies.to_s).to include("Casa do Açaí")
      expect(companies.to_s).to include("Toca do Açaí")
      expect(companies.to_s).to include("Açaí da Esquina")
    end
  end

  context ".sort_by_price" do
    it "returns companies ordered by acai_price" do
      Company.create(name: "Casa do Açaí", phone: "11-11111111", acai_price: "11,00")
      Company.create(name: "Toca do Açaí", phone: "11-11111111", acai_price: "10,00")
      Company.create(name: "Açaí do Açaí", phone: "11-11111111", acai_price: "12,00")
      Company.create(name: "Esquina do Açaí", phone: "11-11111111", acai_price: "8,00")

      companies = Company.sort_by_price()

      expect(companies[0].name).to eq "Esquina do Açaí"
      expect(companies[1].name).to eq "Toca do Açaí"
      expect(companies[2].name).to eq "Casa do Açaí"
      expect(companies[3].name).to eq "Açaí do Açaí"
    end
  end

  context "#inform_open" do
    it "sets the company is_open to true" do
      company = Company.create(name: "Toca do Açaí", phone: "11-11111111")

      company.inform_open

      expect(company.is_open).to eq(true)
      expect(Company.all.first.is_open).to eq(true)
    end

    it "sets the company is_open to true when there is more than one company" do
      Company.create(name: "Casa do Açaí", phone: "11-11111111")
      Company.create(name: "Toca do Açaí", phone: "11-11111112")
      company = Company.create(name: "Caverna do Açaí", phone: "11-11111113")

      company.inform_open

      expect(company.is_open).to eq(true)
      expect(Company.all.last.is_open).to eq(true)
    end
  end

  context "#inform_closed" do
    it "sets the company is_open to false" do
      company = Company.create(name: "Toca do Açaí", phone: "11-11111111")
      company.inform_open

      company.inform_closed

      expect(company.is_open).to eq(false)
      expect(Company.all.first.is_open).to eq(false)
    end

    it "sets the company is_open to false when there is more than one company" do
      Company.create(name: "Casa do Açaí", phone: "11-11111111")
      Company.create(name: "Toca do Açaí", phone: "11-11111112")
      company = Company.create(name: "Caverna do Açaí", phone: "11-11111113")
      company.inform_open

      company.inform_closed

      expect(company.is_open).to eq(false)
      expect(Company.all.last.is_open).to eq(false)
    end
  end

  context "#address" do
    addresses_path = "spec/support/companies-addresses-test.csv"

    after do
      CSV.open(addresses_path, "wb") do |csv|
        csv << %w[id company_id zip street city state]
      end
    end

    it "returns the address from company" do
      stub_const("CompanyAddress::DATA_PATH", addresses_path)
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111")
      CompanyAddress.create(company_id: company.id.to_s, zip: "11111-111", street: "Rua do Açaí, 25", city: "São Paulo",
                            state: "SP")

      address = company.address

      expect(address.street).to eq("Rua do Açaí, 25")
      expect(address.zip).to eq("11111-111")
      expect(address.city).to eq("São Paulo")
      expect(address.state).to eq("SP")
    end
  end

  context "#ratings" do
    ratings_path = "spec/support/ratings-test.csv"

    after do
      CSV.open(ratings_path, "wb") do |csv|
        csv << %w[id company_id customer_id rate content]
      end
    end

    it "returns all company ratings" do
      stub_const("Rating::DATA_PATH", ratings_path)
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111")
      Rating.create(company_id: company.id.to_s, customer_id: "21", rate: "8", content: "Muito bom!")
      Rating.create(company_id: company.id.to_s, customer_id: "26", rate: "1", content: "Péssimo")
      Rating.create(company_id: "84", customer_id: "10", rate: "5", content: "Até que dá pro gasto")

      ratings = company.ratings

      expect(ratings.size).to eq(2)
      expect(ratings.to_s).to include("Péssimo")
      expect(ratings.to_s).to include("Muito bom!")
      expect(ratings.to_s).to_not include("Até que dá pro gasto")
    end
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id name phone is_open acai_price]
    end
  end
end
