# frozen_string_literal: true

require "tem_acai/sale"

RSpec.describe "Purchase" do
  csv_path = "spec/support/sales-test.csv"

  before do
    stub_const("Sale::DATA_PATH", csv_path)
    restart_csv(csv_path)
  end

  after(:all) { restart_csv(csv_path) }

  it "open file" do
    expect { Sale.csv_file }.not_to raise_error
  end

  it "create sale" do
    sale = Sale.create("2", "3", "5", "20.0")

    expect(sale.product_id).to eq("2")
    expect(sale.customer_id).to eq("3")
    expect(sale.company_id).to eq("5")
    expect(sale.amount).to eq("20.0")
  end

  def restart_csv(file_path)
    CSV.open(file_path, "wb") do |csv|
      csv << %w[id product_id customer_id company_id amount]
    end
  end
end
