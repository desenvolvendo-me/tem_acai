# frozen_string_literal: true

RSpec.describe Purchase do
  csv_path = "spec/support/purchases-test.csv"

  before do
    stub_const("Purchase::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  context ".create" do
    it "creates a purchase" do
      purchase = Purchase.create(product_id: "21", amount: "2", price: "10.50")

      expect(purchase.product_id).to eq("21")
      expect(purchase.amount).to eq("2")
      expect(purchase.price).to eq("10.50")
      expect(purchase.id).to be_truthy
    end
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id product_id amount price]
    end
  end
end
