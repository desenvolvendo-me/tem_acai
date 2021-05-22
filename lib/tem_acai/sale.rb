# frozen_string_literal: true

require "csv"

class Sale
  DATA_PATH = "data/sales.csv"
  ID_RANDOM_SET = 2000

  attr_reader :id, :product_id, :customer_id, :company_id, :amount

  def initialize(id, product_id, customer_id, company_id, amount)
    @id = id
    @product_id = product_id
    @customer_id = customer_id
    @company_id = company_id
    @amount = amount
  end

  def self.create(product_id, customer_id, company_id, amount)
    id = rand(ID_RANDOM_SET)
    sale = Sale.new(id, product_id, customer_id, company_id, amount)

    csv_file("ab") do |csv|
      csv << [sale.id, sale.product_id, sale.customer_id, sale.company_id, sale.amount]
    end
    sale
  end

  def self.csv_file(mode = "r")
    CSV.open(DATA_PATH, mode)
  end
end
