# frozen_string_literal: true

require "csv"
class Purchase
  ID_RANDOM_SET = 2000
  DATA_PATH = "data/purchases.csv"

  attr_reader :id, :product_id, :amount, :price

  def initialize(id:, product_id:, amount:, price:)
    @id = id
    @product_id = product_id
    @amount = amount
    @price = price
  end

  def self.create(product_id:, amount:, price:)
    id = rand(ID_RANDOM_SET)

    purchase = Purchase.new(id: id, product_id: product_id, amount: amount, price: price)

    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [purchase.id, purchase.product_id, purchase.amount, purchase.price]
    end

    purchase
  end
end
