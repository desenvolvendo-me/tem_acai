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

      expect(rating.company_id).to eq("123")
      expect(rating.customer_id).to eq("21")
      expect(rating.rate).to eq("8")
      expect(rating.content).to eq("Muito bom!")
      expect(rating.id).to be_truthy
    end
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id company_id customer_id rate content]
    end
  end
end
