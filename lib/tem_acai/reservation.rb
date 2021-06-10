# frozen_string_literal: true

class Reservation
  attr_accessor :quantity, :customer_id, :company_id, :time_to_take

  def initialize(quantity)
    @quantity = quantity
  end

  def valid?
    return false if quantity.zero?
    return false if quantity.negative?

    true
  end
end
