# frozen_string_literal: true

def create_company
  Company.create(name: "Casa do Açaí", address: "somewhere")
end

def rating_attributes
  %w[id name phone is_open acai_price]
end

RSpec.describe Company do
  csv_path = "spec/support/companies-test.csv"

  before do
    stub_const("Company::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  context "create" do
    it "id, name and phone" do
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111", address: "somewhere")

      expect(company.name).to eq("Casa do Açaí")
      expect(company.phone).to eq("11-11111111")
      expect(company.id).to be_truthy
    end

    it "without phone" do
      company = create_company

      expect(company.name).to eq("Casa do Açaí")
      expect(company.phone).to eq("")
    end

    it "default not delivery" do
      company = create_company

      expect(company.delivery?).to eq("Este estabelecimento não faz entrega.")
    end

    it "optional delivery" do
      company = create_company

      company.delivery = (true)

      expect(company.delivery?).to eq("Este estabelecimento faz entrega.")
    end

    it "phone is required if delivery be true" do
      company = Company.create(name: "Casa do Açaí", address: "somewhere", delivery: true)

      expect(company).to eq("O telefone é obrigatório")
    end

    context "reservation açaí" do
      it "should return message when the company makes reservation" do
        company = create_company

        company.reservation = (true)

        expect(company.reservation?).to eq("Este estabelecimento faz reserva.")
      end

      it "should return message when the comapany does not make a reservation" do
        company = create_company

        expect(company.reservation?).to eq("Este estabelimento não faz reserva.")
      end
    end

    it "is_open false by default" do
      company = create_company

      expect(company.is_open?).to eq false
    end

    it "is_reservation false by default" do
      company = Company.create(name: "Casa do Açaí", address: "somewhere")

      expect(company.do_reservation?).to eq(false)
    end

    it "acai_price" do
      company = Company.create(name: "Casa do Açaí", acai_price: "12.50", address: "somewhere")

      expect(company.acai_price).to eq("12.50")
    end

    it "acai_price not required" do
      company = create_company

      expect(company.acai_price).to eq("")
    end

    it "company" do
      companies = Company.all
      Company.create(name: "Casa do Açaí", phone: "11-11111111", address: "Somehwere")
      new_companies = Company.all

      expect(companies).to be_empty
      expect(new_companies.first&.name).to eq("Casa do Açaí")
      expect(new_companies.first&.phone).to eq("11-11111111")
      expect(new_companies.first&.id).to be_truthy
    end

    it "four companies" do
      Company.create(name: "Casa do Açaí", address: "somewhere")
      Company.create(name: "Toca do Açaí", address: "somewhere")
      Company.create(name: "Açaí da Esquina", address: "somewhere")
      Company.create(name: "Tudo Açaí", address: "somewhere")
      companies = Company.all

      expect(companies.length).to eq(4)
    end

    it "don't create without name" do
      company = Company.create(name: nil, address: "somewhere")
      company2 = Company.create(name: "", address: "somewhere")

      expect(company).to eq("O nome do estabelecimento é obrigatório")
      expect(company2).to eq("O nome do estabelecimento é obrigatório")
    end
  end

  context "reservation" do
    it "max time" do
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111", acai_price: "12.00", address: "somewhere")

      company.reservation_max_time = ("10:00")

      expect(company.reservation_max_time).to eq("10:00")
    end

    it "inform reservation" do
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111", acai_price: "12.00", address: "somewhere")

      company.inform_reservation

      expect(company.do_reservation?).to eq(true)
    end

    it "inform reservation if true become false" do
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111", acai_price: "12.00", address: "somewhere")

      2.times { company.inform_reservation }

      expect(company.do_reservation?).to eq(false)
    end
  end

  context "all" do
    it "one Company with its attributes" do
      Company.create(name: "Casa do Açaí", phone: "11-11111111", acai_price: "12.00", address: "somewhere")

      companies = Company.all

      expect(companies.size).to eq 1
      expect(companies.first&.name).to eq("Casa do Açaí")
      expect(companies.first&.phone).to eq("11-11111111")
      expect(companies.first&.is_open?).to eq(false)
      expect(companies.first&.acai_price).to eq("12.00")
      expect(companies.first&.id).to be_truthy
    end

    it "three Companies" do
      Company.create(name: "Casa do Açaí", address: "somewhere")
      Company.create(name: "Toca do Açaí", address: "somewhere")
      Company.create(name: "Açaí da Esquina", address: "somewhere")

      companies = Company.all

      expect(companies.length).to eq(3)
      expect(companies.to_s).to include("Casa do Açaí")
      expect(companies.to_s).to include("Toca do Açaí")
      expect(companies.to_s).to include("Açaí da Esquina")
    end

    it "opened ones" do
      Company.create(name: "Casa do Açaí", address: "somewhere")
      company_second = Company.create(name: "Toca do Açaí", address: "somewhere")
      Company.create(name: "Açaí do Açaí", address: "somewhere")
      company_fourth = Company.create(name: "Esquina do Açaí", address: "somewhere")

      company_second.change_flag
      company_fourth.change_flag

      companies = Company.all_opened

      expect(companies.size).to eq(2)
    end
  end

  context "sort" do
    it "by acai_price" do
      Company.create(name: "Casa do Açaí", phone: "11-11111111", acai_price: "11.00", address: "somewhere")
      Company.create(name: "Toca do Açaí", phone: "11-11111111", acai_price: "10.00", address: "somewhere")
      Company.create(name: "Açaí do Açaí", phone: "11-11111111", acai_price: "12.00", address: "somewhere")
      Company.create(name: "Esquina do Açaí", phone: "11-11111111", acai_price: "8.00", address: "somewhere")

      companies = Company.sort_by_price

      expect(companies[0].name).to eq "Esquina do Açaí"
      expect(companies[1].name).to eq "Toca do Açaí"
      expect(companies[2].name).to eq "Casa do Açaí"
      expect(companies[3].name).to eq "Açaí do Açaí"
    end
  end

  context ".sort_by_open" do
    it "returns companies ordered by open" do
      Company.create(name: "Casa do Açaí", address: "somewhere")
      company_second = Company.create(name: "Toca do Açaí", address: "somewhere")
      Company.create(name: "Açaí do Açaí", address: "somewhere")
      company_fourth = Company.create(name: "Esquina do Açaí", address: "somewhere")

      company_second.change_flag
      company_fourth.change_flag

      companies = Company.sort_by_open

      expect(companies[0].name).to eq("Esquina do Açaí")
      expect(companies[1].name).to eq("Toca do Açaí")
      expect(companies.size).to eq(2)
    end
  end

  context "#change_flag" do
    it "true" do
      company = Company.create(name: "Toca do Açaí", phone: "11-11111111", address: "somewhere")

      company.change_flag

      expect(company.is_open).to eq(true)
      expect(Company.all.first&.is_open).to eq(true)
    end

    it "true for companies" do
      Company.create(name: "Casa do Açaí", phone: "11-11111111", address: "somewhere")
      Company.create(name: "Toca do Açaí", phone: "11-11111112", address: "somewhere")
      company = Company.create(name: "Caverna do Açaí", phone: "11-11111113", address: "somewhere")

      company.change_flag

      expect(company.is_open).to eq(true)
      expect(Company.all.last&.is_open).to eq(true)
    end
  end

  context "#change_flag to close" do
    it "false" do
      company = Company.create(name: "Toca do Açaí", phone: "11-11111111", address: "somewhere")
      company.change_flag

      company.change_flag

      expect(company.is_open).to eq(false)
      expect(Company.all.first&.is_open).to eq(false)
    end

    it "false for companies" do
      Company.create(name: "Casa do Açaí", phone: "11-11111111", address: "somewhere")
      Company.create(name: "Toca do Açaí", phone: "11-11111112", address: "somewhere")
      company = Company.create(name: "Caverna do Açaí", phone: "11-11111113", address: "somewhere")
      company.change_flag

      company.change_flag

      expect(company.is_open).to eq(false)
      expect(Company.all.last&.is_open).to eq(false)
    end
  end

  context "#address" do
    addresses_path = "spec/support/companies-addresses-test.csv"

    after do
      CSV.open(addresses_path, "wb") do |csv|
        csv << %w[id company_id zip street city state]
      end
    end

    it "company" do
      stub_const("CompanyAddress::DATA_PATH", addresses_path)
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111", address: "Somehwere")
      CompanyAddress.create(company_id: company.id.to_s, zip: "11111-111", street: "Rua do Açaí, 25", city: "São Paulo",
                            state: "SP")

      address = company.addresses

      expect(address&.street).to eq("Rua do Açaí, 25")
      expect(address&.zip).to eq("11111-111")
      expect(address&.city).to eq("São Paulo")
      expect(address&.state).to eq("SP")
    end
  end

  context "#ratings" do
    ratings_path = "spec/support/ratings-test.csv"

    after do
      CSV.open(ratings_path, "wb") do |csv|
        csv << %w[id company_id customer_id rate content]
      end
    end

    it "all companies" do
      stub_const("Rating::DATA_PATH", ratings_path)
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111", address: "Somehwere")
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

  context "not create" do
    it "mandatory address" do
      company = Company.create(name: "Casa do Açaí", phone: "11-11111111")

      expect(company).to eq("O endereço deve ser obrigatório")
    end
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << rating_attributes
    end
  end
end
