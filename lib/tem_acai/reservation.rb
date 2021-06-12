# frozen_string_literal: true

class Reservation
  DATA_PATH = "data/reservations.csv"
  attr_accessor :quantity, :customer_id, :company_id, :time_to_take

  def initialize(quantity, customer_id, company_id, time_to_take, id: rand(200))
    @id = id
    @customer_id = customer_id
    @company_id = company_id
    @time_to_take = time_to_take
    @quantity = quantity
  end

  def create(id, customer_id, company_id, quantity, time_to_take)
    CSV.open(DATA_PATH, "ab") do |csv|
      csv << [id, customer_id, company_id, quantity, time_to_take]
    end
    self
  end

  def self.all
    reservations = Helpers.csv_parse(DATA_PATH)
    reservations.map do |reservation|
      Reservation.new(reservation["customer_id"], reservation["company_id"],
                      reservation["quantity"], reservation["time_to_take"], id: reservation["id"])
    end
  end

  def valid?
    return false if quantity.zero? || quantity.negative?

    true
  end

  def self.find(id)
    reservations = Customer.all
    reservations.select do |reservation|
      return reservation if reservation.id == id
    end
  end
end
