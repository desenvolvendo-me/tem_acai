# frozen_string_literal: true

class Reservation
  DATA_PATH = "data/reservations.csv"
  attr_accessor :quantity, :customer_id, :company_id, :time_to_take

  def initialize(quantity, id: rand(200))
    @id = id
    @quantity = quantity
  end

  def create
    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [id, customer_id, company_id, quantity, time_to_take]
    end
    self
  end

  def valid?
    return false if quantity.zero?
    return false if quantity.negative?

    true
  end
end
