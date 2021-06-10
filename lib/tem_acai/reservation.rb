# frozen_string_literal: true

class Reservation
  attr_accessor :quantity

  def initialize(quantity)
    @quantity = quantity
  end

  def valid?
    return false if quantity.zero?
    return false if quantity.negative?

    true
  end
end
