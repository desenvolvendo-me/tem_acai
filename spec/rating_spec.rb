# frozen_string_literal: true

RSpec.describe Rating do
  csv_path = "spec/support/ratings-test.csv"

  before do
    stub_const("Rating::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  context ".create" do
    it "creates a rating for the company" do
      rating = Rating.create(company_id: "123", customer_id: "21", rate: "8", content: "Muito bom!")

      expect(rating.valid?).to eq(true)
      expect(rating.company_id).to eq("123")
      expect(rating.customer_id).to eq("21")
      expect(rating.rate).to eq("8")
      expect(rating.content).to eq("Muito bom!")
      expect(rating.id).to be_truthy
    end

    it "persists the data" do
      Rating.create(company_id: "123", customer_id: "21", rate: "8", content: "Muito bom!")
      Rating.create(company_id: "123", customer_id: "26", rate: "1", content: "Péssimo")
      Rating.create(company_id: "84", customer_id: "10", rate: "5", content: "Até que dá pro gasto")

      ratings = Rating.all

      expect(ratings.last.content).to eq("Até que dá pro gasto")
      expect(ratings.last.rate).to eq("5")
    end
  end

  context "not create" do
    it "without rate" do
      rating = Rating.create(company_id: "123", customer_id: "21", rate: nil, content: "Muito bom!")

      expect(rating.valid?).to eq(false)
    end

    it "persists the data" do
      Rating.create(company_id: "123", customer_id: "21", rate: "8", content: "Muito bom!")
      Rating.create(company_id: "123", customer_id: "26", rate: "1", content: "Péssimo")
      Rating.create(company_id: "84", customer_id: "10", rate: "5", content: "Até que dá pro gasto")

      ratings = Rating.all

      expect(ratings.last.content).to eq("Até que dá pro gasto")
      expect(ratings.last.rate).to eq("5")
    end
  end

  context ".from_company" do
    it "retrieves all company ratings" do
      Rating.create(company_id: "123", customer_id: "21", rate: "8", content: "Muito bom!")
      Rating.create(company_id: "123", customer_id: "26", rate: "1", content: "Péssimo")
      Rating.create(company_id: "84", customer_id: "10", rate: "5", content: "Até que dá pro gasto")

      ratings = Rating.from_company("123")

      expect(ratings.size).to eq(2)
      expect(ratings.to_s).to include("Péssimo")
      expect(ratings.to_s).to include("Muito bom!")
      expect(ratings.to_s).to_not include("Até que dá pro gasto")
    end
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id company_id customer_id rate content]
    end
  end
end
